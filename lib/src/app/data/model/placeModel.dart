import 'package:labour/src/app/domain/entity/place.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.description,
    required super.placeId,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      description: json['description'],
      placeId: json['place_id'],
    );
  }
}
