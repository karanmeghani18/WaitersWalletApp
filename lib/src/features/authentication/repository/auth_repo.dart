import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';
import 'package:waiters_wallet/src/features/authentication/models/wallet_user.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';

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
              .map((e) => RestaurantModel.fromJson(
                    e,
                    e['id'],
                  ))
              .toList()
          : [],
      goals: GoalsModel.fromJson(
        userDoc.data() as Map<String, dynamic>,
      ),
    );
  }

  removeUser() {
    currentUser = null;
  }

  void addRestaurant(RestaurantModel newRestaurant) {
    currentUser = currentUser!.copyWith(
      restaurants: [...currentUser!.restaurants, newRestaurant],
    );
  }

  void deleteRestaurant(String restaurantId) {
    currentUser!.restaurants.removeWhere((e) => e.id == restaurantId);
  }

  WalletUser getUser() {
    return currentUser!;
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    return result.additionalUserInfo!.isNewUser;
  }

  logoutGUser() {}

  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ('Password reset email sent');
    } catch (e) {
      return ('Error sending password reset email: $e');
    }
  }
}
