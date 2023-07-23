import 'package:dartz/dartz.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/data/model/order_model.dart';
import 'package:labour/src/app/data/model/service_model.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/entity/comment.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/entity/order.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/auth/domain/entity/user.dart';
import 'package:labour/src/core/error/failure.dart';

abstract class BaseAppRepository {
  Future<Either<Failure, List<Category>>> getCategories();

  Future<Either<Failure, List<Company>>> getCompany();

  Future<Either<Failure, List<LocationEntity>>> getLocations();

  Future<Either<Failure, void>> addLocation(LocationsModel parameters);

  Future<Either<Failure, void>> deleteLocation(String parameters);

  Future<Either<Failure, void>> addServices(ServiceModel parameters);

  Future<Either<Failure, List<ServiceEntity>>> getServices();

  Future<Either<Failure, void>> setCommentToCompany(
      SetCommentToCompanyParameters parameters);

  Future<Either<Failure, List<CommentEntity>>> getComments(String companyId);

  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, double>> getRating(String companyUid);

  Future<Either<Failure, void>> setRatingToCompany(
      SetRatingToCompanyParameters parameters);

  Future<Either<Failure, void>> saveOrderToFireStore(OrderModel order);
}
