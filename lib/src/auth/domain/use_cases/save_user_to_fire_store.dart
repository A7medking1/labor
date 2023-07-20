import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/auth/data/model/user_model.dart';
import 'package:labour/src/auth/domain/repository/base_auth_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SaveUserToFireStoreUseCase extends BaseUseCase<void, UserParameters> {
  final BaseAuthRepository authRepository;

  SaveUserToFireStoreUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(
      UserParameters parameters) async {
    return await authRepository.saveUserToFireStore(parameters);
  }
}

class UserParameters extends Equatable {

  final UserModel userModel;

  const UserParameters({
    required this.userModel,
  });

  @override
  List<Object> get props => [userModel];
}
