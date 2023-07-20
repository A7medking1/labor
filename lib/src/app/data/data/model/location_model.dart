import 'package:labour/src/app/domain/entity/location.dart';

class LocationsModel extends Location {
  const LocationsModel({
    required super.city,
    required super.region,
    required super.street,
    required super.building,
  });

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    return LocationsModel(
      city: json['city'],
      region: json['region'],
      street: json['street'],
      building: json['building'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'region': region,
      'street': street,
      'building': building,
    };
  }
}
