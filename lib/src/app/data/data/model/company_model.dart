import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:labour/src/app/domain/entity/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.name,
    required super.nameAr,
    required super.desc,
    required super.descAr,
    required super.hour,
    required super.image,
    required super.price,
    required super.uid,
    required super.id,
  });



  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nameAr': nameAr,
      'desc': desc,
      'descAr': descAr,
      'hour': hour,
      'image': image,
      'price': price,
      'id': id,
      'uid': uid,
    };
  }

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      nameAr: json['name_ar'],
      desc: json['desc'],
      descAr: json['desc_ar'],
      hour: json['hour'],
      image: json['image'],
      price: json['price'],
      id: json['id'],
      uid: json['uid'],
    );
  }

  factory CompanyModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return CompanyModel.fromJson(doc.data());
  }
}
