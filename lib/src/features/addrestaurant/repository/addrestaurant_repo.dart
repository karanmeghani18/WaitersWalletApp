import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addRestaurantRepoProvider = Provider((_) => RestaurantRepository());

class RestaurantRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<String> addRestaurant({
    required String restaurantName,
    required double barTipPercentage,
    required double bohTipPercentage,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    String errorText = "";
    await _users.doc(user!.email).collection('restaurants').add({
      'restaurant_name': restaurantName,
      'bar_tip_percentage': barTipPercentage,
      'boh_tip_percentage': bohTipPercentage,
    }).catchError((error) {
      errorText = error;
      return error;
    });
    return errorText;
  }
}
