import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/data/model/location_model.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class AddLocationUseCase extends BaseUseCase<void, LocationsModel> {
  final BaseAppRepository baseAppRepository;

  AddLocationUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(LocationsModel parameters) async {
    return await baseAppRepository.addLocation(parameters);
  }
}

