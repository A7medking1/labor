import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String city;

  final String region;


  final String street;

  final String building;

  const Location({
    required this.city,
    required this.region,
    required this.street,
    required this.building,
  });


  @override
  List<Object> get props => [city, region, street, building];
}


