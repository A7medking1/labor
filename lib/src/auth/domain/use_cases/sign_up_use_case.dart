import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labour/src/auth/domain/repository/base_auth_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SignUpUseCase extends BaseUseCase<UserCredential, SignUpParameters> {
  final BaseAuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(
      SignUpParameters parameters) async {
    return await authRepository.signUp(parameters);
  }
}

class SignUpParameters extends Equatable {
  final String email;

  final String password;

  const SignUpParameters({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
