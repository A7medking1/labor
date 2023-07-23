import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetLocationUseCase extends BaseUseCase<List<LocationEntity>, NoParameters> {
  final BaseAppRepository baseAppRepository;

  GetLocationUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<LocationEntity>>> call(NoParameters parameters) async {
    return await baseAppRepository.getLocations();
  }
}
