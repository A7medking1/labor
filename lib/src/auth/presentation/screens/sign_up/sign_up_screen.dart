import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/auth/presentation/screens/sign_up/widget/build_form_field.dart';
import 'package:labour/src/auth/presentation/screens/sign_up/widget/sign_up_button.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_social_button.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                sl<AppPreferences>()
                    .setUserToken('laYGYgV7kPbdMZ0j0hs5jHdV9vn2')
                    .then((value) {
                  context.goNamed(
                    Routes.homeScreen,
                  );
                });
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const _SignUpScreenContent(),
      ),
    );
  }
}

class _SignUpScreenContent extends StatelessWidget {
  const _SignUpScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Form(
          key: context.read<AuthBloc>().signUpFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.register.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppStrings.descRegister.tr(),
                style: TextStyle(fontSize: 18.sp, color: Colors.grey),
              ),
              SizedBox(
                height: 30.h,
              ),
              const InputFieldBuild(),
              SizedBox(
                height: 30.h,
              ),
              const SignUpButton(),
              SizedBox(
                height: 30.h,
              ),
              Text(
                AppStrings.or.tr(),
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
              CustomSocialMediaButton(
                onTap: () {},
                text: AppStrings.google.tr(),
                icon: AppAssets.google,
              ),
              CustomSocialMediaButton(
                onTap: () {},
                text: AppStrings.facebook.tr(),
                icon: AppAssets.facebook,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
