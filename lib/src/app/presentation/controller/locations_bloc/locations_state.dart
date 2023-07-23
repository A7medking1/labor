part of 'locations_bloc.dart';

enum RequestState { loading, loaded, error, empty }

class LocationsState extends Equatable {
  final String errorMessage;
  final List<LocationEntity> locations;
  final LocationEntity? location;
  final LocationEntity? pickedLocation;


  final RequestState requestState;
  final RequestState? updateState;
  final RequestState addLocReqState;
  final RequestState delLocReqState;

  const LocationsState({
    this.errorMessage = '',
    this.locations = const [],
    this.location,
    this.updateState,
    this.requestState = RequestState.loading,
    this.addLocReqState = RequestState.empty,
    this.delLocReqState = RequestState.empty,
    this.pickedLocation,
  });

  LocationsState copyWith({
    String? errorMessage,
    List<LocationEntity>? locations,
    RequestState? requestState,
    RequestState? addLocReqState,
    RequestState? getLocationState,
    RequestState? delLocReqState,
    LocationEntity? location,
    RequestState? updateState,
    LocationEntity? pickedLocation,
  }) {
    return LocationsState(
      errorMessage: errorMessage ?? this.errorMessage,
      locations: locations ?? this.locations,
      requestState: requestState ?? this.requestState,
      addLocReqState: addLocReqState ?? this.addLocReqState,
      delLocReqState: delLocReqState ?? this.delLocReqState,
      updateState: updateState ?? this.updateState,
      location: location ?? this.location,
      pickedLocation: pickedLocation ?? this.pickedLocation,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        locations,
    updateState,
        location,
        requestState,
        addLocReqState,
    pickedLocation,
        delLocReqState,
      ];
}
