import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/place_detail_entity.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetPlaceDetailsUseCase extends BaseUseCase<PlaceDetailEntity, String> {
  final BaseAppRepository baseAppRepository;

  GetPlaceDetailsUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, PlaceDetailEntity>> call(String parameters) async {
    return await baseAppRepository.getPlaceDetails(parameters);
  }
}
