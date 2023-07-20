import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:labour/src/app/data/data/model/comment_entity.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class SetCommentToCompanyUseCase
    extends BaseUseCase<void, SetCommentToCompanyParameters> {
  final BaseAppRepository baseAppRepository;

  SetCommentToCompanyUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, void>> call(
      SetCommentToCompanyParameters parameters) async {
    return await baseAppRepository.setCommentToCompany(parameters);
  }
}

class SetCommentToCompanyParameters extends Equatable {
  final CommentModel commentModel;
  final String companyUid;

  const SetCommentToCompanyParameters({
    required this.commentModel,
    required this.companyUid,
  });

  @override
  List<Object> get props => [commentModel, companyUid];
}
