import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider((_) => AuthenticationRepository());
FirebaseFirestore firestore = FirebaseFirestore.instance;

class AuthenticationRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<String> addUser({
    required String fullName,
    required String email,
  }) async {
    String errorText = "";
    await users.add({
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on FirebaseAuthException catch(e) {
      String errorMessage = "";
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      return errorMessage;
    }
  }
}
