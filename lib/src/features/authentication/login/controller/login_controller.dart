import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';

part 'login_state.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
  (ref) => LoginController(repository: ref.read(authRepoProvider)),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController({
    required AuthenticationRepository repository,
  })  : _repository = repository,
        super(const LoginState());
  final AuthenticationRepository _repository;

  Future logIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: LoginStatus.loginUser);
    String errorText =
        await _repository.loginUser(email: email, password: password);
    if (errorText.isEmpty) {
      state = state.copyWith(status: LoginStatus.loginUserSuccess);
      await _repository.fetchUser(email);
    } else {
      state = state.copyWith(
        status: LoginStatus.loginUserFailure,
        errorText: errorText,
      );
    }
  }
}
