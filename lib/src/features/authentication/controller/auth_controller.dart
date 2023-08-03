import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../../addtip/models/restaurant_model.dart';
import '../../restaurants/addrestaurant/repository/addrestaurant_repo.dart';
import '../models/wallet_user.dart';
import '../repository/auth_repo.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

part 'auth_state.dart';

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) => AuthController(
    repository: ref.read(authRepoProvider),
    restaurantRepository: ref.read(addRestaurantRepoProvider),
  ),
);

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required AuthenticationRepository repository,
    required RestaurantRepository restaurantRepository,
  })  : _repository = repository,
        _restaurantRepository = restaurantRepository,
        super(const AuthState());
  final AuthenticationRepository _repository;
  final RestaurantRepository _restaurantRepository;

  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  Future<bool> authenticateWithBiometrics() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(
          localizedReason: "Use Biometrics to authenticate",
          authMessages: [
            const AndroidAuthMessages(
              signInTitle: "Sign In",
              cancelButton: "No Thanks",
            ),
            const IOSAuthMessages(cancelButton: "No Thanks"),
          ],
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ));
    } catch (e) {
      debugPrint("error $e");
      return false;
    }
  }

  Future signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.signingUpUser);
    String errorText =
        await _repository.signUpUser(email: email, password: password);
    if (errorText.isEmpty) {
      _createNewUserInDB(fullName, email);
    } else {
      state = state.copyWith(
          status: AuthStatus.signingUpUserFailure, errorText: errorText);
    }
  }

  Future _createNewUserInDB(String fullName, String email) async {
    String errorString =
        await _repository.addUser(fullName: fullName, email: email);
    if (errorString.isEmpty) {
      _repository.currentUser = WalletUser(
        fullName: fullName,
        email: email,
        restaurants: [],
      );
      state = state.copyWith(status: AuthStatus.signingUpUserSuccess);
    } else {
      state = state.copyWith(
          status: AuthStatus.signingUpUserFailure, errorText: errorString);
    }
  }

  Future _fetchAndSetUser(String email) async {
    await _repository.fetchUser(email);
    List<RestaurantModel> restaurants =
        await _restaurantRepository.fetchRestaurant();
    for (var element in restaurants) {
      _repository.addRestaurant(element);
    }
  }

  Future logIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loginUser);
    String errorText =
        await _repository.loginUser(email: email, password: password);
    if (errorText.isEmpty) {
      await _fetchAndSetUser(email);
      state = state.copyWith(status: AuthStatus.loginUserSuccess);
    } else {
      state = state.copyWith(
        status: AuthStatus.loginUserFailure,
        errorText: errorText,
      );
    }
  }

  Future logInWithGoogle() async {
    try {
      final bool isNewUser = await _repository.signInWithGoogle();
      final currentUser = FirebaseAuth.instance.currentUser!;
      print(isNewUser);
      if (isNewUser) {
        _createNewUserInDB(currentUser.displayName!, currentUser.email!);
      } else {
        await _fetchAndSetUser(currentUser.email!);
      }
      state = state.copyWith(status: AuthStatus.gSignInSuccess);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.gSignInSignUpFailure,
        errorText: e.toString(),
      );
      print(e);
    }
  }
}
