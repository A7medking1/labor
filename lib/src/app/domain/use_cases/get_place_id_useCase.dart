import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/place.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetPlaceIdUseCase extends BaseUseCase<List<PlaceEntity>, String> {
  final BaseAppRepository baseAppRepository;

  GetPlaceIdUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<PlaceEntity>>> call(String parameters) async {
    return await baseAppRepository.getPlaceId(parameters);
  }
}
