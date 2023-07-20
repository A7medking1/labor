import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetRatingUseCase extends BaseUseCase<double, String> {
  final BaseAppRepository baseAppRepository;

  GetRatingUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, double>> call(String parameters) async {
    return await baseAppRepository.getRating(parameters);
  }
}
