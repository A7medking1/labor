import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/entity/place.dart';
import 'package:labour/src/app/domain/entity/place_detail_entity.dart';
import 'package:labour/src/app/domain/use_cases/add_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/delete_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_place_details_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_place_id_useCase.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:rxdart/rxdart.dart';

part 'locations_event.dart';

part 'locations_state.dart';

const _duration = Duration(milliseconds: 800);

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc(
    this.getLocationUseCase,
    this.addLocationUseCase,
    this.deleteLocationUseCase,
    this.getPlaceIdUseCase,
    this.getPlaceDetailsUseCase,
  ) : super(const LocationsState()) {
    on<GetLocationsEvent>(_getLocations);
    on<AddLocationEvent>(_addLocation);
    on<DeleteLocationEvent>(_delLocation);
    on<GetLocationFromPrefsEvent>(_getLocationFromPrefs);
    on<GetCurrentLocationEvent>(_getCurrentLocation);
    on<UpdateMapLocationEvent>(_updateLocationMap);
    on<GetPlaceIdEvent>(
      _getPlacesEvent,
      transformer: (event, mapper) {
        return (event).debounceTime(_duration).flatMap(mapper);
      },
    );
    on<GetPlaceDetailsEvent>(_getPlaceDetails);
  }

  final GetLocationUseCase getLocationUseCase;
  final AddLocationUseCase addLocationUseCase;
  final DeleteLocationUseCase deleteLocationUseCase;
  final GetPlaceIdUseCase getPlaceIdUseCase;
  final GetPlaceDetailsUseCase getPlaceDetailsUseCase;

  String currentLocation = '';

  String address = '';

  String city = '';

  String street = '';

  String region = '';

  String building = '';

  FloatingSearchBarController? controller = FloatingSearchBarController();

  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(31.037933, 31.381523),
    zoom: 17,
  );

  CameraPosition? goToSearchCameraPosition;

  PlaceEntity? placeSuggestion;

/*
  Marker? searchMarker = const Marker(
    position: LatLng(31.037933, 31.381523),
    markerId: MarkerId(
      '1',
    ),
    infoWindow: InfoWindow(title: 'google'),
  );
*/

  void buildCameraNewPosition(LatLng latLng) {
    goToSearchCameraPosition = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: latLng,
      zoom: 17,
    );
  }

  Marker placeMarker = const Marker(
    position: LatLng(31.037933, 31.381523),
    markerId: MarkerId(
      'id',
    ),
    infoWindow: InfoWindow(title: 'google'),
  );

  LatLng currentLatLang = const LatLng(31.037933, 31.381523);

  FutureOr<void> _getLocations(
      GetLocationsEvent event, Emitter<LocationsState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await getLocationUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          errorMessage: l.message,
          requestState: RequestState.error,
        ),
      ),
      (r) {
        print(r.length);
        if (r.isEmpty) {
          emit(
            state.copyWith(
              requestState: RequestState.empty,
            ),
          );
        } else {
          emit(
            state.copyWith(
              requestState: RequestState.loaded,
              locations: r,
            ),
          );
          print('state.locations.length ${state.locations.length}');
        }
      },
    );
  }

  FutureOr<void> _addLocation(
      AddLocationEvent event, Emitter<LocationsState> emit) async {
    emit(state.copyWith(addLocReqState: RequestState.loading));

    final result = await addLocationUseCase(event.location);

    result.fold(
      (l) {
        emit(
          state.copyWith(
            errorMessage: l.message,
            addLocReqState: RequestState.error,
          ),
        );
      },
      (r) {
        emit(state.copyWith(addLocReqState: RequestState.loaded));
      },
    );
    //add(GetLocationsEvent());
  }

  FutureOr<void> _delLocation(
      DeleteLocationEvent event, Emitter<LocationsState> emit) async {
    emit(state.copyWith(
      delLocReqState: RequestState.loading,
    ));
    final result = await deleteLocationUseCase(event.city);
    result.fold(
      (l) {
        emit(
          state.copyWith(
            errorMessage: l.message,
            delLocReqState: RequestState.error,
          ),
        );
      },
      (r) {
        emit(state.copyWith(
          delLocReqState: RequestState.loaded,
        ));
        add(GetLocationsEvent());
      },
    );
  }

  FutureOr<void> _getLocationFromPrefs(
      GetLocationFromPrefsEvent event, Emitter<LocationsState> emit) {
    emit(state.copyWith(requestState: RequestState.loading));
    final prefs = sl<AppPreferences>().getLocation();
    emit(state.copyWith(location: prefs, requestState: RequestState.loaded));
  }

  Future<void> getAddressFromLatLang(LatLng latLng) async {
    List<Placemark> placeMark = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'en');
    print(placeMark);
    Placemark place = placeMark[0];
    /* address =
        '${place.street} -- ${place.subLocality} -- ${place.locality} -- ${place.country}';*/
    city = place.administrativeArea ?? '';
    street = place.street ?? '';
    region = place.locality ?? '';
    building = place.thoroughfare ?? '';

    print(address);
  }

  FutureOr<void> _getCurrentLocation(
      GetCurrentLocationEvent event, Emitter<LocationsState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return await Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return await Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return await Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getCurrentPosition().then((value) {
      currentLatLang = LatLng(value.latitude, value.longitude);
      getAddressFromLatLang(LatLng(value.latitude, value.longitude));
    });
  }

  FutureOr<void> _updateLocationMap(
      UpdateMapLocationEvent event, Emitter<LocationsState> emit) async {
    cameraPosition = CameraPosition(
      target: event.latLng,
      zoom: 17,
    );

    placeMarker = Marker(
      position: event.latLng,
      markerId: const MarkerId(
        'id',
      ),
      infoWindow: const InfoWindow(title: 'google'),
    );

    emit(
      state.copyWith(
        pickedLocation: LocationEntity(
          city: city,
          region: region,
          street: street,
          building: building,
        ),
      ),
    );
  }

  FutureOr<void> _getPlacesEvent(
      GetPlaceIdEvent event, Emitter<LocationsState> emit) async {
    emit(state.copyWith(searchReqState: RequestState.loading));

    final result = await getPlaceIdUseCase(event.place);

    result.fold(
      (l) => emit(
        state.copyWith(
          searchReqState: RequestState.error,
        ),
      ),
      (r) {
        if (r.isEmpty) {
          emit(state.copyWith(searchReqState: RequestState.empty));
        } else {
          emit(
            state.copyWith(
              searchReqState: RequestState.loaded,
              places: r,
            ),
          );
        }
      },
    );
  }

  FutureOr<void> _getPlaceDetails(
      GetPlaceDetailsEvent event, Emitter<LocationsState> emit) async {
    emit(state.copyWith(placeDetailsReqState: RequestState.loading));

    final result = await getPlaceDetailsUseCase(event.placeId);

    result.fold(
      (l) => emit(
        state.copyWith(
          placeDetailsReqState: RequestState.error,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            placeDetailsReqState: RequestState.loaded,
            placeDetails: r,
          ),
        );
      },
    );
  }
}
