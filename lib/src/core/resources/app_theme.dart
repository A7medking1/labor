import 'package:flutter/material.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/font_manager.dart';
import 'package:labour/src/core/resources/style.dart';

ThemeData getAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xFFF9FFF6),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      backgroundColor: Colors.white,
      titleTextStyle: getBoldStyle(),
      iconTheme: const IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 10.0,
      selectedIconTheme: IconThemeData(color: AppColors.green),
      unselectedIconTheme: IconThemeData(color: Colors.white),
      unselectedItemColor: Colors.black,
    ),
    textTheme: TextTheme(
      displayLarge: getMediumStyle(fontSize: FontSize.s30),
      displayMedium: getRegularStyle(fontSize: FontSize.s24),
      headlineLarge: getSemiBoldStyle(fontSize: FontSize.s30),
      headlineMedium: getRegularStyle(fontSize: FontSize.s24),
      titleMedium: getBoldStyle(fontSize: FontSize.s24),
      titleLarge: getSemiBoldStyle(fontSize: FontSize.s30),
      titleSmall: getBoldStyle(fontSize: FontSize.s16),
      bodyLarge: getBoldStyle(
        color: AppColors.black,
        fontSize: FontSize.s28,
      ),
      bodySmall: getBoldStyle(color: Colors.grey),
      bodyMedium:
          getRegularStyle(color: AppColors.grey2, fontSize: FontSize.s20),
      labelSmall: getBoldStyle(
        color: AppColors.green,
        fontSize: FontSize.s12,
      ),
    ),
  );
}
