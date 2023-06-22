import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/authentication/models/wallet_user.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';

part 'signup_state.dart';

final signUpControllerProvider =
    StateNotifierProvider.autoDispose<SignUpController, SignUpState>(
  (ref) => SignUpController(repository: ref.read(authRepoProvider)),
);

class SignUpController extends StateNotifier<SignUpState> {
  SignUpController({
    required AuthenticationRepository repository,
  })  : _repository = repository,
        super(const SignUpState());
  final AuthenticationRepository _repository;

  Future signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: SignUpStatus.signingUpUser);
    String errorText =
        await _repository.signUpUser(email: email, password: password);
    if (errorText.isEmpty) {
      String errorString =
          await _repository.addUser(fullName: fullName, email: email);
      if (errorText.isEmpty) {
        _repository.currentUser = WalletUser(
          fullName: fullName,
          email: email,
          restaurants: [],
        );
        state = state.copyWith(status: SignUpStatus.signingUpUserSuccess);
      } else {
        state = state.copyWith(
            status: SignUpStatus.signingUpUserFailure, errorText: errorString);
      }
    } else {
      state = state.copyWith(
          status: SignUpStatus.signingUpUserFailure, errorText: errorText);
    }
  }
}
