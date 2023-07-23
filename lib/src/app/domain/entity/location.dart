import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String city;

  final String region;


  final String street;

  final String building;

  const LocationEntity({
    required this.city,
    required this.region,
    required this.street,
    required this.building,
  });


  @override
  List<Object> get props => [city, region, street, building];
}


