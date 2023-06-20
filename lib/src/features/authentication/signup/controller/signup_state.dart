part of 'signup_controller.dart';


enum SignUpStatus {
  initial,
  signingUpUser,
  signingUpUserFailure,
  signingUpUserSuccess,
}

class SignUpState extends Equatable {
  const SignUpState({
    this.status = SignUpStatus.initial,
    this.errorText = "",

  });

  final SignUpStatus status;
  final String errorText;

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorText,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status,errorText];
}
