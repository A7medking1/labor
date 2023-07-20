import 'package:flutter/material.dart';
import 'package:labour/src/core/resources/app_colors.dart';

enum ToastStates { SUCCESS, ERROR, WARNING }

void showToast(String body, ToastStates state,context) {

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsetsDirectional.all(20),
      content: Text(body,textAlign: TextAlign.center,),
      backgroundColor: chooseToastColor(state),
      duration: const Duration(seconds: 1),
    ),
  );
  /*Get.snackbar(
    body,
    "",
    colorText: Colors.white,
    titleText: Center(
        child: Text(
      body,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
    )),
    backgroundColor: chooseToastColor(state),
    duration: const Duration(milliseconds: 700),
    snackPosition: SnackPosition.BOTTOM,
  );*/
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = AppColors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = AppColors.errorRed;
      break;
  }
  return color;
}