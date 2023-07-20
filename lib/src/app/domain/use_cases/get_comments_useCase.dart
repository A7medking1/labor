import 'package:dartz/dartz.dart';
import 'package:labour/src/app/domain/entity/comment.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/core/error/failure.dart';
import 'package:labour/src/core/use_case/base_use_case.dart';

class GetCommentsUseCase extends BaseUseCase<List<CommentEntity>, String> {
  final BaseAppRepository baseAppRepository;

  GetCommentsUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<CommentEntity>>> call(String parameters) async {
    return await baseAppRepository.getComments(parameters);
  }
}
