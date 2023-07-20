import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/firebase_options.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/resources/app_theme.dart';
import 'package:labour/src/core/resources/language_manager.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ServicesLocator().init();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocal, englishLocal],
      fallbackLocale: englishLocal,
      path: assetsLocalization,
      child: Phoenix(
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) {
      return context.setLocale(local);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => sl<CategoryBloc>()..add(GetCategoriesEvent())),
            BlocProvider(
              create: (_) => sl<AuthBloc>(),
            ),
            BlocProvider(
              create: (context) =>
                  sl<ProfileBloc>()..add(GetCurrentUserEvent()),
            ),
            BlocProvider(
                create: (_) => sl<LocationsBloc>()
                  ..add(GetLocationsEvent())
                  ..add(const GetLocationFromPrefsEvent())),
            BlocProvider(
              create: (_) => sl<HomeBloc>()
                ..add(GetHomeDataEvent())
                ..add(GetCompanyDataEvent()),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: getAppTheme(),
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
