import 'package:labour/src/app/domain/entity/place_detail_entity.dart';

class PlaceDetailModel extends PlaceDetailEntity {
  const PlaceDetailModel({
    required super.lat,
    required super.lng,
  });

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
