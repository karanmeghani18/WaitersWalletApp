import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/authentication/repository/auth_repo.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/repository/addrestaurant_repo.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';

part 'addrestaurant_state.dart';

final addRestaurantControllerProvider = StateNotifierProvider.autoDispose<
    AddRestaurantController, AddRestaurantState>(
  (ref) => AddRestaurantController(
    repository: ref.read(addRestaurantRepoProvider),
    authRepo: ref.read(authRepoProvider),
  ),
);

class AddRestaurantController extends StateNotifier<AddRestaurantState> {
  AddRestaurantController({
    required RestaurantRepository repository,
    required AuthenticationRepository authRepo,
  })  : _repository = repository,
        _authRepo = authRepo,
        super(const AddRestaurantState());
  final RestaurantRepository _repository;
  final AuthenticationRepository _authRepo;

  Future<void> addRestaurant({
    required RestaurantModel restaurantModel,
  }) async {
    state = state.copyWith(status: AddRestaurantStatus.addingRestaurant);
    try {
      await _repository.addRestaurant(
        restaurantModel: restaurantModel,
      );
      _authRepo.addRestaurant(restaurantModel);
      state =
          state.copyWith(status: AddRestaurantStatus.addingRestaurantSuccess);
    } catch (e) {
      state = state.copyWith(
        status: AddRestaurantStatus.addingRestaurantFailure,
        message: e.toString(),
      );
    }
  }

  List<RestaurantModel> getRestaurants() {
    return _authRepo.currentUser?.restaurants ?? [];
  }
}
