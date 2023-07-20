import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labour/src/app/domain/entity/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.nameAr,
    required super.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      nameAr: json['name_ar'],
    );
  }

  factory CategoryModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CategoryModel.fromJson(doc.data());
  }
}
