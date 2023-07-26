import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:labour/src/app/data/model/category_model.dart';
import 'package:labour/src/app/data/model/comment_entity.dart';
import 'package:labour/src/app/data/model/company_model.dart';
import 'package:labour/src/app/data/model/location_model.dart';
import 'package:labour/src/app/data/model/order_model.dart';
import 'package:labour/src/app/data/model/placeModel.dart';
import 'package:labour/src/app/data/model/place_detail_model.dart';
import 'package:labour/src/app/data/model/service_model.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/auth/data/model/user_model.dart';
import 'package:labour/src/core/api/api_constant.dart';
import 'package:labour/src/core/api/api_consumer.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/error/exception.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:uuid/uuid.dart';

abstract class BaseRemoteAppDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<List<CompanyModel>> getCompanies();

  Future<List<LocationsModel>> getLocations();

  Future<void> addLocations(LocationsModel parameters);

  Future<void> deleteLocations(String parameters);

  Future<void> addServices(ServiceModel parameters);

  Future<List<ServiceModel>> getServices();

  Future<void> setCommentToCompany(SetCommentToCompanyParameters parameters);

  Future<void> setRatingToCompany(SetRatingToCompanyParameters parameters);

  Future<List<CommentModel>> getComments(String companyId);

  Future<double> getRating(String companyUid);

  Future<UserModel> getCurrentUser();

  Future<void> saveOrder(OrderModel orderModel);

  Future<List<PlaceModel>> getPlaceId(String place);

  Future<PlaceDetailModel> getPlaceDetails(String placeId);
}

class AppRemoteDataSource extends BaseRemoteAppDataSource {
  final FirebaseFirestore firebaseFireStore;
  final ApiConsumer apiConsumer;

  AppRemoteDataSource(this.firebaseFireStore, this.apiConsumer);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final collection = firebaseFireStore.collection('categories');

      final result = await collection.get();

      return List<CategoryModel>.from(
        (result.docs).map((e) => CategoryModel.fromFireStore(e)),
      );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<List<CompanyModel>> getCompanies() async {
    try {
      final collection = firebaseFireStore.collection('company');

      final result = await collection.get();

      return List<CompanyModel>.from(
        (result.docs).map((e) => CompanyModel.fromFireStore(e)),
      );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<List<LocationsModel>> getLocations() async {
    try {
      String token = sl<AppPreferences>().getUserToken();

      final collection = firebaseFireStore
          .collection('user')
          .doc(token)
          .collection('location');

      final result = await collection.get();

      return List<LocationsModel>.from(
          (result.docs).map((e) => LocationsModel.fromJson(e.data())));
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> addLocations(LocationsModel parameters) async {
    try {
      final token = sl<AppPreferences>().getUserToken();

      final collection = firebaseFireStore
          .collection('user')
          .doc(token)
          .collection('location');

      await collection.doc(const Uuid().v4()).set(
            parameters.toJson(),
          );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> deleteLocations(String city) async {
    try {
      String token = sl<AppPreferences>().getUserToken();

      final collection = firebaseFireStore
          .collection('user')
          .doc(token)
          .collection('location');

      await collection.where("city", isEqualTo: city).get().then((value) {
        for (var element in value.docs) {
          collection.doc(element.id).delete().then((value) {
            print("Success!");
          });
        }
      });
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> addServices(ServiceModel parameters) async {
    try {
      final token = sl<AppPreferences>().getUserToken();

      final collection =
          firebaseFireStore.collection('user').doc(token).collection('service');

      await collection.doc(parameters.serviceUid).set(
            parameters.toJson(),
          );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<List<ServiceModel>> getServices() async {
    try {
      final token = sl<AppPreferences>().getUserToken();

      final collection =
          firebaseFireStore.collection('user').doc(token).collection('service');

      final result = await collection.get();

      return List<ServiceModel>.from(
          (result.docs).map((e) => ServiceModel.fromJson(e.data())));
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> setCommentToCompany(
      SetCommentToCompanyParameters parameters) async {
    try {
      await firebaseFireStore
          .collection('company')
          .doc(parameters.companyUid)
          .collection('comment')
          .doc(const Uuid().v1())
          .set(
            parameters.commentModel.toJson(),
          );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<List<CommentModel>> getComments(String companyId) async {
    try {
      final res = firebaseFireStore
          .collection('company')
          .doc(companyId)
          .collection('comment');

      final list = await res.get();

      return List<CommentModel>.from(
          (list.docs).map((e) => CommentModel.fromJson(e.data())));
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final token = sl<AppPreferences>().getUserToken();
    try {
      final collection = firebaseFireStore.collection('user').doc(token);

      final result = await collection.get();

      return UserModel.fromJson(result.data()!);
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> setRatingToCompany(
      SetRatingToCompanyParameters parameters) async {
    final token = sl<AppPreferences>().getUserToken();
    try {
      final coll = FirebaseFirestore.instance
          .collection('company')
          .doc(
            parameters.companyUid,
          )
          .collection('rate');
      await coll.doc(token).set({
        'rate': parameters.rating,
      });
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<double> getRating(String companyUid) async {
    try {
      final coll = FirebaseFirestore.instance
          .collection('company')
          .doc(
            companyUid,
          )
          .collection('rate');

      final data = await coll.get();

/*
      double result =
          data.docs.map((m) => m['rate']).reduce((a, b) => a + b) / data.size;
*/

      double sum = 0;

      data.docs.forEach((element) {
        // print('rate ${element.data()['rate']}' );
        sum += element.data()['rate'];
      });

      if (sum == 0) {
        return 0.0;
      }

      double average = sum / data.size;

      print(average.toStringAsFixed(1));
      // print(double.parse(result.toStringAsFixed(1)));
      return double.parse(average.toStringAsFixed(1));
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<void> saveOrder(OrderModel orderModel) async {
    try {
      final token = sl<AppPreferences>().getUserToken();

      final collection =
          firebaseFireStore.collection('user').doc(token).collection('order');

      await collection.doc(orderModel.orderUid).set(
            orderModel.toJson(),
          );
    } on FirebaseException catch (e) {
      throw FireException(e.message);
    }
  }

  @override
  Future<List<PlaceModel>> getPlaceId(String place) async {
    Response result = await apiConsumer.get(
      ApiMapConstant.getPlaceId,
      queryParameters: {
        'input': place,
        'type': 'address',
        'key': ApiMapConstant.apiKey,
        'components': 'country:eg',
        'sessiontoken': const Uuid().v4(),
      },
    );
    return List<PlaceModel>.from((result.data['predictions'] as List)
        .map((e) => PlaceModel.fromJson(e)));
  }

  @override
  Future<PlaceDetailModel> getPlaceDetails(String placeId) async {
    Response result = await apiConsumer.get(
      ApiMapConstant.getPlaceDetails,
      queryParameters: {
        'place_id': placeId,
        'key': ApiMapConstant.apiKey,
        'sessiontoken': const Uuid().v4(),
      },
    );
    return PlaceDetailModel.fromJson(
      result.data['result']['geometry']['location'],
    );
  }
}
