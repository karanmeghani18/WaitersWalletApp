import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/addrestaurant/repository/addrestaurant_repo.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';

part 'addrestaurant_state.dart';

final addRestaurantControllerProvider = StateNotifierProvider.autoDispose<
    AddRestaurantController, AddRestaurantState>(
  (ref) => AddRestaurantController(
    repository: ref.read(addRestaurantRepoProvider),
  ),
);

class AddRestaurantController extends StateNotifier<AddRestaurantState> {
  AddRestaurantController({
    required RestaurantRepository repository,
  })  : _repository = repository,
        super(const AddRestaurantState());
  final RestaurantRepository _repository;

  Future<void> addRestaurant({
    required RestaurantModel restaurantModel,
  }) async {
    await _repository.addRestaurant(
      restaurantName: restaurantModel.restaurantName,
      barTipPercentage: restaurantModel.barTipOut,
      bohTipPercentage: restaurantModel.bohTipOut,
    );
  }
}
