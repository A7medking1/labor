import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_text_button.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/on_boarding/presentation/widget/page_view_builder.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: _OnBoardingScreenContent(),
      ),
    );
  }
}

class _OnBoardingScreenContent extends StatelessWidget {
   const _OnBoardingScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        Container(
          width: double.infinity,
          padding:  EdgeInsetsDirectional.only(end: 30.w, top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(
                text: AppStrings.skip.tr(),
                fontColor: Colors.amberAccent,
                onPressed: () {
                  sl<AppPreferences>().setOnBoarding();
                  context.goNamed(Routes.login);
                },
              ),
            ],
          ),
        ),
         SizedBox(
          height: 120.h,
        ),
        const Expanded(
          child: PageViewBuilder(),
        ),
      ]),
    );
  }
}




