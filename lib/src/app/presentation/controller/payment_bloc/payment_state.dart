part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}


class GetAuthTokenLoadingState extends PaymentState {}
class GetAuthTokenSuccessState extends PaymentState {}
class GetAuthTokenErrorState extends PaymentState {}


class GetOrderIdLoadingState extends PaymentState {}
class GetOrderIdSuccessState extends PaymentState {}
class GetOrderIdErrorState extends PaymentState {}


class GetPaymentRequestLoadingState extends PaymentState {}
class GetPaymentRequestSuccessState extends PaymentState {}
class GetPaymentRequestErrorState extends PaymentState {}



class GetPaymentMobileWalletLoadingState extends PaymentState {}
class GetPaymentMobileWalletSuccessState extends PaymentState {}
class GetPaymentMobileWalletErrorState extends PaymentState {}