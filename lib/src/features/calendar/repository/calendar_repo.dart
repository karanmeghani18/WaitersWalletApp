import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../addtip/models/tip_model.dart';

final calendarRepoProvider = Provider((_) => CalendarRepository());

class CalendarRepository {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');


  Future<String> addTipToFirebase(TipModel tipModel, String tipId) async {
    String errorText = "";
    final User? currentUser = FirebaseAuth.instance.currentUser;
    try {
      await _users
          .doc(currentUser!.email)
          .collection("tips")
          .doc(tipId)
          .set(tipModel.toJson());
    } on FirebaseException catch (e) {
      errorText = e.message.toString();
    }

    return errorText;
  }
}
