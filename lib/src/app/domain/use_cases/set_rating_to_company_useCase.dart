import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SetRatingToCompanyUseCase
    extends BaseUseCase<void, SetRatingToCompanyParameters> {
  final BaseAppRepository baseAppRepository;

  SetRatingToCompanyUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(
      SetRatingToCompanyParameters parameters) async {
    return await baseAppRepository.setRatingToCompany(parameters);
  }
}

class SetRatingToCompanyParameters extends Equatable {
  final String companyUid;
  final double rating;

  const SetRatingToCompanyParameters({
    required this.rating,
    required this.companyUid,
  });

  @override
  List<Object> get props => [rating, companyUid];
}
