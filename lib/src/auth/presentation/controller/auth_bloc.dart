import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/auth/data/model/user_model.dart';
import 'package:labour/src/auth/domain/use_cases/login_use_case.dart';
import 'package:labour/src/auth/domain/use_cases/save_user_to_fire_store.dart';
import 'package:labour/src/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:labour/src/core/app_prefs/app_prefs.dart';
import 'package:labour/src/core/resources/routes_manager.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';

part 'auth_event.dart';

part 'auth_state.dart';

enum AuthRequestState {
  success,
  loading,
  error,
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.loginUseCase,
    this.signUpUseCase,
    this.userToFireStoreUseCase,
  ) : super(const AuthState()) {
    on<LogInEvent>(_logIn);
    on<SignUpEvent>(_signUp);
    on<SaveUserToFireStoreEvent>(_saveUser);
    on<SendOtpToPhoneEvent>(_sendOtpToPhone);
    on<VerifySentOtpEvent>(_verifySentOtp);
  }

  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final SaveUserToFireStoreUseCase userToFireStoreUseCase;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController codeSms = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  Country country = Country(
    phoneCode: '20',
    countryCode: 'EG',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'Egypt',
    example: '1001234567',
    displayName: 'Egypt (EG) [+20]',
    displayNameNoCountryCode: 'Egypt (EG)',
    e164Key: '20-EG-0',
  );


  FutureOr<void> _logIn(LogInEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        loading: true,
        logInState: AuthRequestState.loading,
      ),
    );
    final result = await loginUseCase(
      LoginParameters(email: event.email, password: event.password),
    );
    print('in');

    result.fold(
      (l) {
        print(l.message);

        emit(
          state.copyWith(
            message: l.message,
            logInState: AuthRequestState.error,
            loading: false,
          ),
        );
      },
      (r) {
        print(r.user!.email);

        emit(
          state.copyWith(
            logInState: AuthRequestState.success,
            user: r,
            loading: false,
          ),
        );
      },
    );
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(
      state.copyWith(
        loading: true,
        signUpSate: AuthRequestState.loading,
      ),
    );
    final result = await signUpUseCase(
      SignUpParameters(email: event.email, password: event.password),
    );

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.message,
          signUpSate: AuthRequestState.error,
          loading: false,
        ),
      ),
      (r) => emit(
        state.copyWith(
          signUpSate: AuthRequestState.success,
          loading: false,
          user: r,
        ),
      ),
    );
  }

  FutureOr<void> _saveUser(
      SaveUserToFireStoreEvent event, Emitter<AuthState> emit) async {
    final result =
        await userToFireStoreUseCase(UserParameters(userModel: event.user));
    result.fold((l) => print('error'), (r) => print('save user'));
  }

  FutureOr<void> _sendOtpToPhone(
      SendOtpToPhoneEvent event, Emitter<AuthState> emit) async {
    print('+${country.phoneCode}${phone.text}'.trim());
    await sl<FirebaseAuth>().verifyPhoneNumber(
      phoneNumber: '+${country.phoneCode}${phone.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {},
      codeSent: (String verificationId, int? resendToken) {
        event.context.pushNamed(Routes.verifyScreen, queryParameters: {
          'verify_id': verificationId,
          'phone_number': phone.text,
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  FutureOr<void> _verifySentOtp(
      VerifySentOtpEvent event, Emitter<AuthState> emit) async {
    print('in bloc ${phone.text},${userName.text}');

    emit(state.copyWith(phoneAuthState: PhoneAuthState.loading));

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.codeSms,
      );
      final res = await sl<FirebaseAuth>().signInWithCredential(credential);
      if (res.additionalUserInfo!.isNewUser) {
        add(
          SaveUserToFireStoreEvent(
            UserModel(
              uid: res.user!.uid,
              phone: phone.text,
              image:
                  'https://img.freepik.com/free-vector/flat-young-businessman-sitting-huge-red-question-mark_126523-2881.jpg?w=740&t=st=1689628435~exp=1689629035~hmac=b2b09d83ea276aa6a1cb711eb8e076d560296eebde98355b961c276ab8092cfe',
              name: userName.text,
              email: email.text,
            ),
          ),
        );
      } else {
        print('isNewUser ${res.additionalUserInfo!.isNewUser}');
      }
      sl<AppPreferences>().setUserToken(res.user!.uid);
      emit(state.copyWith(phoneAuthState: PhoneAuthState.loaded));
    } on FirebaseAuthException catch (e) {
      print('e.message ${e.message}');
      emit(state.copyWith(phoneAuthState: PhoneAuthState.error));
    }
  }
}
