import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:labour/src/app/data/datasource/remote_data_source.dart';
import 'package:labour/src/app/data/repository/app_repository.dart';
import 'package:labour/src/app/domain/repository/base_app_repository.dart';
import 'package:labour/src/app/domain/use_cases/add_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/add_services_useCase.dart';
import 'package:labour/src/app/domain/use_cases/delete_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_category_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_comments_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_current_user_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_locations_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_rating_useCase.dart';
import 'package:labour/src/app/domain/use_cases/get_services_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/app/presentation/controller/company_bloc/company_bloc.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/app/presentation/controller/payment_bloc/payment_cubit.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/cubit/step_cubit.dart';
import 'package:labour/src/auth/data/datasource/remote_data_source.dart';
import 'package:labour/src/auth/data/repository/auth_repository.dart';
import 'package:labour/src/auth/domain/repository/base_auth_repository.dart';
import 'package:labour/src/auth/domain/use_cases/login_use_case.dart';
import 'package:labour/src/auth/domain/use_cases/save_user_to_fire_store.dart';
import 'package:labour/src/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/api/api_consumer.dart';
import 'package:labour/src/core/api/dio_consumer.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    /// prefs
    final sharedPrefs = await SharedPreferences.getInstance();

    sl.registerFactory<SharedPreferences>(() => sharedPrefs);

    sl.registerLazySingleton<AppPreferences>(() => AppPreferences(sl()));

    /// Auth

    final auth = FirebaseAuth.instance;

    sl.registerFactory(() => auth);

    sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl()));

    sl.registerFactory(() => LoginUseCase(sl()));

    sl.registerFactory(() => SignUpUseCase(sl()));

    sl.registerFactory(() => SaveUserToFireStoreUseCase(sl()));

    sl.registerLazySingleton<BaseRemoteAuthDataSource>(
        () => AuthRemoteDataSource(sl(), sl()));
//
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));
//

    ///app

    final fireStore = FirebaseFirestore.instance;
    sl.registerFactory(() => fireStore);
    sl.registerLazySingleton<BaseRemoteAppDataSource>(
        () => AppRemoteDataSource(sl()));
    sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));
    sl.registerLazySingleton(() => GetCategoryUseCase(sl()));
    sl.registerLazySingleton(() => GetCompanyUseCase(sl()));
    sl.registerLazySingleton(() => GetLocationUseCase(sl()));
    sl.registerLazySingleton(() => AddLocationUseCase(sl()));
    sl.registerLazySingleton(() => DeleteLocationUseCase(sl()));
    sl.registerLazySingleton(() => AddServicesUseCase(sl()));
    sl.registerLazySingleton(() => GetServicesUseCase(sl()));
    sl.registerLazySingleton(() => SetCommentToCompanyUseCase(sl()));
    sl.registerLazySingleton(() => GetCommentsUseCase(sl()));
    sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
    sl.registerLazySingleton(() => SetRatingToCompanyUseCase(sl()));
    sl.registerLazySingleton(() => GetRatingUseCase(sl()));

    sl.registerFactory<CategoryBloc>(() => CategoryBloc(sl()));
    sl.registerFactory<CompanyBloc>(() => CompanyBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl(), sl(), sl()));
    sl.registerFactory<StepCubit>(() => StepCubit());
    sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
    sl.registerFactory<LocationsBloc>(() => LocationsBloc(sl(), sl(), sl()));

    sl.registerLazySingleton<Dio>(() => Dio());

    sl.registerLazySingleton(
      () => PrettyDioLogger(
        responseBody: false,
        requestBody: false,
      ),
    );

    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

    sl.registerFactory(() => PaymentCubit(sl()));
  }
}
