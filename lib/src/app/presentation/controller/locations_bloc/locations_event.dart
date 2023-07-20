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
