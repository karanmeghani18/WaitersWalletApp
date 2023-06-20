part of 'login_controller.dart';


enum LoginStatus {
  initial,
  loginUser,
  loginUserFailure,
  loginUserSuccess,
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.errorText = "",

  });

  final LoginStatus status;
  final String errorText;

  LoginState copyWith({
    LoginStatus? status,
    String? errorText,
  }) {
    return LoginState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}
