import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:labour/src/auth/domain/use_cases/login_use_case.dart';
import 'package:labour/src/auth/domain/use_cases/save_user_to_fire_store.dart';
import 'package:labour/src/auth/domain/use_cases/sign_up__with_phone_number_use_case.dart';
import 'package:labour/src/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:labour/src/core/error/failure.dart';

abstract class BaseAuthRepository {
  Future<Either<Failure, UserCredential>> logIn(LoginParameters parameters);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserCredential>> signUp(SignUpParameters parameters);

  Future<Either<Failure, void>> saveUserToFireStore(UserParameters parameters);

  Future<Either<Failure, void>> signUpWithPhoneNumber(SignUpPhoneNumberParameters parameters);
}
