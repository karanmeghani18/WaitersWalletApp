import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';

final goalsRepoProvider = Provider((_) => GoalsRepo());

class GoalsRepo {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addGoalsToFirebase(GoalsModel goals) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await _users
        .doc(currentUser!.email)
        .collection("goals")
        .add(goals.toJson());
  }

  // Future<void> setGoalsToFirebase(GoalsModel goals) async {
  //   final User? currentUser = FirebaseAuth.instance.currentUser;
  //   await _users
  //       .doc(currentUser!.email)
  //       .collection("goals")
  //       .
  // }

  Future<List<ScheduleModel>> fetchScheduleFromDb() async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    List<ScheduleModel> schedules = [];
    final scheduleCollection =
    await _users.doc(currentUser!.email).collection("schedule").get();
    for (var scheduleJson in scheduleCollection.docs) {
      final ScheduleModel scheduleModel = ScheduleModel.fromJson(
        scheduleJson.data(),
        scheduleJson.id,
      );
      schedules.add(scheduleModel);
    }
    return schedules;
  }
}
