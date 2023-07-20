import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/auth/presentation/controller/auth_bloc.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/flutter_toast.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifySentOtpScreen extends StatefulWidget {
  final String verifyId;
  final String phoneNumber;

  const VerifySentOtpScreen(
      {Key? key, required this.verifyId, required this.phoneNumber})
      : super(key: key);

  @override
  State<VerifySentOtpScreen> createState() => _VerifySentOtpScreen();
}

class _VerifySentOtpScreen extends State<VerifySentOtpScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print("listener ${state.phoneAuthState}");

        if (state.phoneAuthState == PhoneAuthState.loading) {
          OverlayLoadingProgress.start(context);
        }
        if (state.phoneAuthState == PhoneAuthState.loaded) {
          OverlayLoadingProgress.stop();
          sl<AppPreferences>().getLocation();
          context.goNamed(Routes.homeScreen);
        }
        if (state.phoneAuthState == PhoneAuthState.error) {
          OverlayLoadingProgress.stop();
          showToast(
              'The multifactor verification code used to create the auth credential is invalid',
              ToastStates.ERROR,
              context);
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(),
            body: Container(
              padding: const EdgeInsetsDirectional.all(20),
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    AppStrings.otp.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    AppStrings.otp_desc.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.phoneNumber,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.greenAccent),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  PinCodeTextField(
                    length: 6,
                    appContext: context,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    autoDisposeControllers: false,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      inactiveFillColor: Colors.grey,
                      inactiveColor: Colors.grey,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    enableActiveFill: true,
                    controller: context.read<AuthBloc>().codeSms,
                    onCompleted: (v) {
                      print("Completed");
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    onTap: () {
                      final bloc = context.read<AuthBloc>();

                      if (bloc.codeSms.text.length == 6) {
                        print("submit");
                        //  print(context.read<AuthBloc>().userName.text);
                        //  print(context.read<AuthBloc>().phone.text);
                        bloc.add(
                          VerifySentOtpEvent(
                            codeSms: bloc.codeSms.text,
                            verificationId: widget.verifyId,
                            context: context,
                          ),
                        );
                      }
                    },
                    text: AppStrings.submit.tr(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CodeResendCounter(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CodeResendCounter extends StatefulWidget {
  const CodeResendCounter({
    super.key,
  });

  @override
  State<CodeResendCounter> createState() => _CodeResendCounterState();
}

class _CodeResendCounterState extends State<CodeResendCounter> {
  Timer? _timer;

  int seconds = 120;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!.cancel();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (seconds == 0) {
            timer.cancel();
          } else {
            seconds--;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.code_sent_resend_code_in.tr(),
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.grey,
              ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          '$minutes:${remainingSeconds.toString().padLeft(2, '0')}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.yellow.shade900,
              ),
        ),
      ],
    );
  }
}
