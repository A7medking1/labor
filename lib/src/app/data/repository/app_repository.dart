import 'package:dartz/dartz.dart';
import 'package:labour/src/app/data/datasource/remote_data_source.dart';
import 'package:labour/src/app/data/model/order_model.dart';
import 'package:labour/src/app/data/model/service_model.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/domain/entity/comment.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/entity/location.dart';
import 'package:labour/src/app/domain/entity/place.dart';
import 'package:labour/src/app/domain/entity/place_detail_entity.dart';
import 'package:labour/src/app/domain/entity/service_entity.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/auth/domain/entity/user.dart';
import 'package:labour/src/core/error/exception.dart';
import 'package:labour/src/core/error/failure.dart';

import '../model/location_model.dart';

class AppRepository extends BaseAppRepository {
  final BaseRemoteAppDataSource remoteAppDataSource;

  AppRepository(this.remoteAppDataSource);

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await remoteAppDataSource.getCategories();
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<Company>>> getCompany() async {
    try {
      final result = await remoteAppDataSource.getCompanies();
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations() async {
    try {
      final result = await remoteAppDataSource.getLocations();
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> addLocation(LocationsModel parameters) async {
    try {
      final result = await remoteAppDataSource.addLocations(parameters);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLocation(String parameters) async {
    try {
      final result = await remoteAppDataSource.deleteLocations(parameters);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> addServices(ServiceModel parameters) async {
    try {
      final result = await remoteAppDataSource.addServices(parameters);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<ServiceEntity>>> getServices() async {
    try {
      final result = await remoteAppDataSource.getServices();
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setCommentToCompany(
      SetCommentToCompanyParameters parameters) async {
    try {
      final result = await remoteAppDataSource.setCommentToCompany(parameters);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      String companyId) async {
    try {
      final result = await remoteAppDataSource.getComments(companyId);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final result = await remoteAppDataSource.getCurrentUser();
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> setRatingToCompany(
      SetRatingToCompanyParameters parameters) async {
    try {
      final result = await remoteAppDataSource.setRatingToCompany(parameters);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, double>> getRating(String companyUid) async {
    try {
      final result = await remoteAppDataSource.getRating(companyUid);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, void>> saveOrderToFireStore(OrderModel order) async {
    try {
      final result = await remoteAppDataSource.saveOrder(order);
      return Right(result);
    } on FireException catch (e) {
      return Left(ServerFailure(e.message!));
    }
  }

  @override
  Future<Either<Failure, List<PlaceEntity>>> getPlaceId(String place) async {
    try {
      final result = await remoteAppDataSource.getPlaceId(place);

      return Right(result);
    } on FireException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, PlaceDetailEntity>> getPlaceDetails(
      String placeId) async {
    try {
      final result = await remoteAppDataSource.getPlaceDetails(placeId);
      return Right(result);
    } on FireException catch (failure) {
      return Left(ServerFailure(failure.message!));
    }
  }
}
