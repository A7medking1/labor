import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetServicesUseCase extends BaseUseCase<List<ServiceEntity> , NoParameters> {
  final BaseAppRepository baseAppRepository;

  GetServicesUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<ServiceEntity>>> call(NoParameters parameters) async{
   return await baseAppRepository.getServices();
  }


}
