part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogInEvent extends AuthEvent {
  final String email;

  final String password;

  const LogInEvent(this.email, this.password);
}

class SignUpEvent extends AuthEvent {
  final String email;

  final String password;

  const SignUpEvent(this.email, this.password);
}

class SaveUserToFireStoreEvent extends AuthEvent {
  final UserModel user;

  const SaveUserToFireStoreEvent(this.user);
}

class SendOtpToPhoneEvent extends AuthEvent {
  final String phoneNumber;
  final BuildContext context;

  const SendOtpToPhoneEvent({required this.phoneNumber, required this.context});
}

class VerifySentOtpEvent extends AuthEvent {
  final String codeSms;

  final UserModel? user;

  final String verificationId;

  final BuildContext context;


  const VerifySentOtpEvent({
    required this.codeSms,
    this.user,
    required this.context,
    required this.verificationId,
  });
}
