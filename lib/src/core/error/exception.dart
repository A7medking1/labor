import 'package:equatable/equatable.dart';

class FireException extends Equatable implements Exception {
  final String? message;

  const FireException([this.message]);

  @override
  List<Object?> get props => [message];
}