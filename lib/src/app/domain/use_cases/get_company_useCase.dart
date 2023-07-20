import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetCompanyUseCase extends BaseUseCase<List<Company>, NoParameters> {
  final BaseAppRepository baseAppRepository;

  GetCompanyUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<Company>>> call(NoParameters parameters) async {
    return await baseAppRepository.getCompany();
  }
}
