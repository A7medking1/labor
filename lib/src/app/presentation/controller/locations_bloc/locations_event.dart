part of 'locations_bloc.dart';

abstract class LocationsEvent extends Equatable {
  const LocationsEvent();

  @override
  List<Object> get props => [];
}

class GetLocationsEvent extends LocationsEvent {}

class AddLocationEvent extends LocationsEvent {
  final LocationsModel location;

  const AddLocationEvent(this.location);
}

class GetLocationFromPrefsEvent extends LocationsEvent {
  const GetLocationFromPrefsEvent();
}

class DeleteLocationEvent extends LocationsEvent {
  final String city;

  const DeleteLocationEvent(this.city);
}

class GetCurrentLocationEvent extends LocationsEvent {}

class UpdateMapLocationEvent extends LocationsEvent {
  final LatLng latLng;

  const UpdateMapLocationEvent(this.latLng);
}

class GetPlaceIdEvent extends LocationsEvent {
  final String place;

  const GetPlaceIdEvent(this.place);
}


class GetPlaceDetailsEvent extends LocationsEvent {
  final String placeId;

  const GetPlaceDetailsEvent(this.placeId);
}
