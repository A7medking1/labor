import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labour/src/auth/domain/repository/base_auth_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SignUpPhoneNumberUseCase
    extends BaseUseCase<void, SignUpPhoneNumberParameters> {
  final BaseAuthRepository authRepository;

  SignUpPhoneNumberUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(
      SignUpPhoneNumberParameters parameters) async {
    return await authRepository.signUpWithPhoneNumber(parameters);
  }
}

class SignUpPhoneNumberParameters extends Equatable {
  final String phoneNumber;
  final Function(PhoneAuthCredential) verificationCompleted;
  final Function(FirebaseAuthException) verificationFailed;
  final Function(String, int?) codeSent;
  final Function(String) codeAutoRetrievalTimeout;

  const SignUpPhoneNumberParameters({
    required this.phoneNumber,
    required this.verificationCompleted,
    required this.verificationFailed,
    required this.codeSent,
    required this.codeAutoRetrievalTimeout,
  });

  @override
  List<Object> get props => [
        phoneNumber,
        verificationCompleted,
        verificationFailed,
        codeSent,
        codeAutoRetrievalTimeout,
      ];
}
