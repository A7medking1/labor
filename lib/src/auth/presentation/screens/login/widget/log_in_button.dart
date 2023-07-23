import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        /*  if (state.logInState == AuthRequestState.error) {
          showToast(state.message, ToastStates.ERROR, context);
        }
        if (state.logInState == AuthRequestState.success) {
          sl<AppPreferences>().setUserToken(state.user!.user!.uid);
          context.goNamed(Routes.homeScreen);
        }*/
      },
      builder: (context, state) {
        return !state.loading
            ? CustomButton(
                text: AppStrings.login.tr(),
                onTap: () async {
                  /*bloc.email.text = 'ahmed@010.com';
                  bloc.password.text = '123123123';*/
                  if (bloc.loginFormKey.currentState!.validate()) {
                    //bloc.add(LogInEvent(bloc.email.text, bloc.password.text));
                    bloc.add(
                      SendOtpToPhoneEvent(
                        phoneNumber: bloc.phone.text,
                        context: context,
                      ),
                    );
                  }
                },
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
