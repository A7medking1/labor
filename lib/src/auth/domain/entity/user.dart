import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;

  final String name;
  final String email;
  final String? image;
  final String? phone;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    this.image,
    this.phone,
  });

  @override
  List<Object?> get props => [uid, name, image];
}
