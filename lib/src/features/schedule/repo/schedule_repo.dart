import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';

final scheduleRepoProvider = Provider((_) => ScheduleRepo());

class ScheduleRepo {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addScheduleToFirebase(ScheduleModel schedule) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await _users
        .doc(currentUser!.email)
        .collection("schedule")
        .doc(schedule.id)
        .set(schedule.toJson());
  }

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

  Future deleteSchedule(ScheduleModel schedule) async{
    final User? currentUser = FirebaseAuth.instance.currentUser;
    await _users
        .doc(currentUser!.email)
        .collection("schedule")
        .doc(schedule.id)
        .delete();
  }
}
