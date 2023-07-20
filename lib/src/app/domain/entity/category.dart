import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;

  final String name;

  final String nameAr;

  final String image;

  const Category({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.image,
  });

  @override
  List<Object> get props => [id, name, nameAr, image];
}
