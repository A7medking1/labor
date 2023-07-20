import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/use_cases/add_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/delete_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_locations_useCase.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

part 'locations_event.dart';

part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  LocationsBloc(
    this.getLocationUseCase,
    this.addLocationUseCase,
    this.deleteLocationUseCase,
  ) : super(const LocationsState()) {
    on<GetLocationsEvent>(_getLocations);
    on<AddLocationEvent>(_addLocation);
    on<DeleteLocationEvent>(_delLocation);
    on<GetLocationFromPrefsEvent>(_getLocationFromPrefs);
  }

  final GetLocationUseCase getLocationUseCase;
  final AddLocationUseCase addLocationUseCase;
  final DeleteLocationUseCase deleteLocationUseCase;

  String currentLocation = '';

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
}
