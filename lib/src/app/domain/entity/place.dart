import 'package:equatable/equatable.dart';

class PlaceEntity extends Equatable {
  final String description;
  final String placeId;

  const PlaceEntity({
    required this.description,
    required this.placeId,
  });

  @override
  List<Object> get props => [description, placeId];
}
