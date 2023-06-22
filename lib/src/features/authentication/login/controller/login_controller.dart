import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/repository/addrestaurant_repo.dart';

part 'login_state.dart';

final loginControllerProvider =
    StateNotifierProvider.autoDispose<LoginController, LoginState>(
  (ref) => LoginController(
    repository: ref.read(authRepoProvider),
    restaurantRepository: ref.read(addRestaurantRepoProvider),
  ),
);

class LoginController extends StateNotifier<LoginState> {
  LoginController({
    required AuthenticationRepository repository,
    required RestaurantRepository restaurantRepository,
  })  : _repository = repository,
        _restaurantRepository = restaurantRepository,
        super(const LoginState());
  final AuthenticationRepository _repository;
  final RestaurantRepository _restaurantRepository;

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
      List<RestaurantModel> restaurants =
          await _restaurantRepository.fetchRestaurant();
      for (var element in restaurants) {
        _repository.addRestaurant(element);
      }
    } else {
      state = state.copyWith(
        status: LoginStatus.loginUserFailure,
        errorText: errorText,
      );
    }
  }
}
