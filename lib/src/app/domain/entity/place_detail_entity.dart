import 'package:equatable/equatable.dart';

class PlaceDetailEntity extends Equatable {
  final double lat;

  final double lng;

  const PlaceDetailEntity({
    required this.lat,
    required this.lng,
  });


  @override
  List<Object> get props => [lat, lng];
}
