import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String name;
  final String nameAr;
  final String desc;
  final String descAr;
  final String hour;
  final String image;
  final int price;
  final int id;
  final String uid;

  const Company({
    required this.name,
    required this.nameAr,
    required this.desc,
    required this.descAr,
    required this.hour,
    required this.image,
    required this.price,
    required this.id,
    required this.uid,
  });

  @override
  List<Object> get props => [id,name, nameAr, desc, descAr, hour, image, price,uid];
}
