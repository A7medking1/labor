part of 'auth_bloc.dart';

enum PhoneAuthState { loading, loaded, error }

class AuthState extends Equatable {
  final AuthRequestState logInState;
  final AuthRequestState signUpSate;
  final UserCredential? user;
  final String message;
  final bool loading;

  final PhoneAuthState? phoneAuthState;

  const AuthState({
    this.logInState = AuthRequestState.loading,
    this.message = '',
    this.loading = false,
    this.phoneAuthState,
    this.user,
    this.signUpSate = AuthRequestState.loading,
  });

  AuthState copyWith({
    AuthRequestState? logInState,
    AuthRequestState? signUpSate,
    String? message,
    UserCredential? user,
    PhoneAuthState? phoneAuthState,
    bool? loading,
  }) {
    return AuthState(
      logInState: logInState ?? this.logInState,
      signUpSate: signUpSate ?? this.signUpSate,
      message: message ?? this.message,
      loading: loading ?? this.loading,
      user: user ?? this.user,
      phoneAuthState: phoneAuthState ?? this.phoneAuthState,
    );
  }

  @override
  List<Object?> get props =>
      [user, signUpSate, logInState, message, loading, phoneAuthState];
}
