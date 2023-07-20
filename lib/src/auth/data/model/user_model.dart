import 'package:labour/src/auth/domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    super.phone,
    super.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': super.email,
      'name': super.name,
      'phone': super.phone,
      'uid': super.uid,
      'image': super.image,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      phone: json['phone'],
    );
  }
}
