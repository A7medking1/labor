import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AppPreferences _preferences = sl<AppPreferences>();

  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 1), () => _goNext());
  }

  _goNext() async {
    final isUserLogged = _preferences.isUserLoggedIn();

    if (isUserLogged) {
      context.goNamed(Routes.homeScreen);
    } else {
      final isOnBoarding = _preferences.isOnBoardingInPrefs();

      if (isOnBoarding) {
        context.goNamed(Routes.login);
      } else {
        final isOnBoardingLang = _preferences.isOnBoardingLangInPrefs();
        if (isOnBoardingLang) {
          context.goNamed(Routes.onBoarding);
        } else {
          context.goNamed(Routes.onBoardingLang);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            AppAssets.splash,
          ),
        ),
      ),
    );
  }
}
