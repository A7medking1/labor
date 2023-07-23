import 'package:labour/src/app/domain/entity/order.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.serviceEntity,
    required super.leaveNotes,
    required super.coupon,
    required super.totalPrice,
    required super.orderUid,
    required super.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'service': serviceEntity.toJson(),
      'leave_notes': leaveNotes,
      'coupon': coupon,
      'total_price': totalPrice,
      'order_uid': orderUid,
      'date': date,
    };
  }
}
