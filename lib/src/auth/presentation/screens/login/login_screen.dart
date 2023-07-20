import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/auth/presentation/screens/login/widget/build_form_field.dart';
import 'package:labour/src/auth/presentation/screens/login/widget/log_in_button.dart';
import 'package:labour/src/core/presentation/widget/custom_social_button.dart';
import 'package:labour/src/core/presentation/widget/custom_text_button.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: const LoginScreenContent(),
      ),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Form(
              key: bloc.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.login.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppStrings.desc.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.w200, fontSize: 20),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  const InputFieldBuild(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CustomTextButton(
                      text: AppStrings.forgetPassword.tr(),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const SignInButton(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    AppStrings.or.tr(),
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.noAccount.tr(),
                      ),
                      CustomTextButton(
                        text: AppStrings.signUp.tr(),
                        onPressed: () => context.pushNamed(Routes.signUp),
                        fontColor: AppColors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
