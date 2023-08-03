part of 'auth_controller.dart';

enum AuthStatus {
  initial,
  loginUser,
  loginUserFailure,
  loginUserSuccess,
  signingUpUser,
  signingUpUserFailure,
  signingUpUserSuccess,
  gSignInSignUp,
  gSignInSuccess,
  gSignInFailure,
  gSignUpSuccess,
  gSignUpFailure,
  gSignInSignUpFailure,
}

class AuthState extends Equatable{
  const AuthState({
    this.status = AuthStatus.initial,
    this.errorText = "",
  });

  final AuthStatus status;
  final String errorText;

  AuthState copyWith({
    AuthStatus? status,
    String? errorText,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status,errorText];

}