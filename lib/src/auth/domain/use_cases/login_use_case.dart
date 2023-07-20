import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labour/src/auth/domain/repository/base_auth_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class LoginUseCase extends BaseUseCase<UserCredential, LoginParameters> {
  final BaseAuthRepository authRepository;

  LoginUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(
      LoginParameters parameters) async {
    return await authRepository.logIn(parameters);
  }
}

class LoginParameters extends Equatable {
  final String email;

  final String password;

  const LoginParameters({
    required this.email,
   required this.password,
  });

  @override
  List<Object> get props => [email,password];
}
