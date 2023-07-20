import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetCategoryUseCase extends BaseUseCase<List<Category>, NoParameters> {
  final BaseAppRepository baseAppRepository;

  GetCategoryUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParameters parameters) async {
    return await baseAppRepository.getCategories();
  }
}
