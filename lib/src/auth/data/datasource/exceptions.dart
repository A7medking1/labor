import 'package:equatable/equatable.dart';

class AuthException extends Equatable implements Exception {
  final String? message;

  const AuthException([this.message]);

  @override
  List<Object?> get props => [message];
}
/*
class UserNotFoundException extends AuthException {
  const UserNotFoundException([message]) : super(message);
}

class WrongPasswordException extends AuthException {
  const WrongPasswordException([message]) : super(message);
}

class InvalidEmailException extends AuthException {
  const InvalidEmailException([message]) : super(message);
}

class UserDisabledException extends AuthException {
  const UserDisabledException([message]) : super(message);
}

class WeakPasswordException extends AuthException {
  const WeakPasswordException([message]) : super(message);
}

class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException([message]) : super(message);
}

class TooManyRequestException extends AuthException {
  const TooManyRequestException([message]) : super(message);
}*/
