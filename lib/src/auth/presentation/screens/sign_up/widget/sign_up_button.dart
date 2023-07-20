import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/resources/app_strings.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print('SignUpButton state.phoneAuthState ${state.phoneAuthState}');
        return CustomButton(
          text: AppStrings.register.tr(),
          onTap: () {
            /*bloc.add(SendOtpToPhoneEvent(
              phoneNumber: bloc.phone.text,
              context: context,
            ));*/
            if (bloc.signUpFormKey.currentState!.validate()) {
              print(bloc.phone.text);
              print(bloc.userName.text);
              bloc.add(SendOtpToPhoneEvent(
                phoneNumber: bloc.phone.text,
                context: context,
              ));
            }
          },
        );
      },
    );
  }
}
