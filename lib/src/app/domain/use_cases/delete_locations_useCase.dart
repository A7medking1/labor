import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class DeleteLocationUseCase extends BaseUseCase<void, String> {
  final BaseAppRepository baseAppRepository;

  DeleteLocationUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(String parameters) async {
    return await baseAppRepository.deleteLocation(parameters);
  }
}


