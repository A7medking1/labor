import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/auth/domain/entity/user.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetCurrentUserUseCase extends BaseUseCase<User, NoParameters> {
  final BaseAppRepository baseAppRepository;

  GetCurrentUserUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, User>> call(NoParameters parameters) async {
    return await baseAppRepository.getCurrentUser();
  }
}
