import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../addtip/models/restaurant_model.dart';

final addRestaurantRepoProvider = Provider((_) => RestaurantRepository());

class RestaurantRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<String> addRestaurant({
    required RestaurantModel restaurantModel,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    String errorText = "";
    await _users
        .doc(user!.email)
        .collection('restaurants')
        .doc(restaurantModel.id)
        .set(restaurantModel.toJson())
        .catchError((error) {
      errorText = error;
      return error;
    });
    return errorText;
  }

  Future<void> deleteRestaurant(String restaurantId) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await _users
        .doc(currentUser!.email)
        .collection("restaurants")
        .doc(restaurantId)
        .delete();
  }

  Future<List<RestaurantModel>> fetchRestaurant() async {
    User? user = FirebaseAuth.instance.currentUser;
    List<RestaurantModel> restaurants = [];
    final userDoc =
        await _users.doc(user!.email).collection('restaurants').get();
    for (var element in userDoc.docs) {
      restaurants.add(RestaurantModel.fromJson(element.data(), element.id));
    }
    return restaurants;
  }
}
