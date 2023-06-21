import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';
import 'package:waiters_wallet/src/features/authentication/models/wallet_user.dart';

final authRepoProvider = Provider((_) => AuthenticationRepository());

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  WalletUser? currentUser;

  Future<String> addUser({
    required String fullName,
    required String email,
  }) async {
    String errorText = "";
    await _users.doc(email).set({
      'full_name': fullName,
      'email': email,
    }).catchError((error) {
      errorText = error;
      return error;
    });
    return errorText;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Unknown error occured';
      }
    }
  }

  Future loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await fetchUser(email);
      return "";
    } on FirebaseAuthException catch (e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = "Unknown error";
      }
      return errorMessage;
    }
  }

  Future<void> fetchUser(String email) async {
    final DocumentSnapshot<Object?> userDoc = await _users.doc(email).get();

    currentUser = WalletUser(
      email: userDoc.get("email"),
      fullName: userDoc.get("full_name"),
      restaurants: userDoc.data().toString().contains('restaurants')
          ? userDoc
              .get('restaurants')
              .entries
              .map((e) => RestaurantModel(
                    restaurantName: e["name"],
                    barTipOut: e["bar_tip_out"],
                    bohTipOut: e["boh_tip_out"],
                    id: e["id"],
                  ))
              .toList()
          : [],
    );
  }

  removeUser() {
    currentUser = null;
  }

  WalletUser getUser() {
    return currentUser!;
  }
}
