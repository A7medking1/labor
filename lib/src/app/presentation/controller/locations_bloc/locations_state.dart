part of 'locations_bloc.dart';

enum RequestState { loading, loaded, error, empty }

class LocationsState extends Equatable {
  final String errorMessage;
  final List<Location> locations;
  final Location? location;

  final RequestState requestState;
  final RequestState addLocReqState;
  final RequestState delLocReqState;

  const LocationsState({
    this.errorMessage = '',
    this.locations = const [],
    this.location,
    this.requestState = RequestState.loading,
    this.addLocReqState = RequestState.empty,
    this.delLocReqState = RequestState.empty,
  });

  LocationsState copyWith({
    String? errorMessage,
    List<Location>? locations,
    RequestState? requestState,
    RequestState? addLocReqState,
    RequestState? getLocationState,
    RequestState? delLocReqState,
    Location? location,
  }) {
    return LocationsState(
      errorMessage: errorMessage ?? this.errorMessage,
      locations: locations ?? this.locations,
      requestState: requestState ?? this.requestState,
      addLocReqState: addLocReqState ?? this.addLocReqState,
      delLocReqState: delLocReqState ?? this.delLocReqState,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        errorMessage,
        locations,
        location,
        requestState,
        addLocReqState,
        delLocReqState,
      ];
}
