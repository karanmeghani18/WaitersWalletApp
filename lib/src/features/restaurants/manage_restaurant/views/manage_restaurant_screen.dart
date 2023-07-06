import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/Views/addrestaurant_screen.dart';
import 'package:waiters_wallet/src/features/restaurants/addrestaurant/controller/addrestaurant_controller.dart';
import 'package:waiters_wallet/src/features/restaurants/manage_restaurant/widgets/restaurant_tile.dart';

import '../../../../constants/color_constants.dart';

class ManageRestaurantScreen extends ConsumerStatefulWidget {
  const ManageRestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ManageRestaurantScreen> createState() =>
      _ManageRestaurantScreenState();
}

class _ManageRestaurantScreenState
    extends ConsumerState<ManageRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                const Text(
                  "Restaurants",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: ref
                  .watch(addRestaurantControllerProvider.notifier)
                  .getRestaurants()
                  .length,
              itemBuilder: (context, index) {
                final RestaurantModel restaurant = ref
                    .watch(addRestaurantControllerProvider.notifier)
                    .getRestaurants()[index];
                return RestaurantTile(
                  restaurantName: restaurant.restaurantName,
                  kitchenTipOut: restaurant.bohTipOut,
                  barTipOut: restaurant.barTipOut,
                  onDismiss: () {},
                  confirmDismiss: () async => true,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showBarModalBottomSheet(
            context: context,
            builder: (context) => const AddRestaurantScreen(),
          );
        },
        backgroundColor: skinColorConst,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
