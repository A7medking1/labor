import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/model/service_model.dart';

class OrderEntity extends Equatable {
 final ServiceModel serviceEntity;

  final String leaveNotes;

  final String coupon;
  final String date;

  final double totalPrice;

  final String orderUid;

  const OrderEntity({
    required this.serviceEntity,
    required this.leaveNotes,
    required this.coupon,
    required this.totalPrice,
    required this.orderUid,
    required this.date,
  });
  @override
  List<Object> get props => [leaveNotes, coupon, totalPrice, orderUid];
}
