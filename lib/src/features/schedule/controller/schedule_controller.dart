import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/schedule/models/schedule_model.dart';

import '../repo/schedule_repo.dart';

part 'schedule_state.dart';

final scheduleControllerProvider =
    StateNotifierProvider.autoDispose<ScheduleController, ScheduleState>(
  (ref) => ScheduleController(
    repository: ref.read(
      scheduleRepoProvider,
    ),
  ),
);

class ScheduleController extends StateNotifier<ScheduleState> {
  ScheduleController({
    required ScheduleRepo repository,
  })  : _repository = repository,
        super(const ScheduleState());
  final ScheduleRepo _repository;

  Future<void> addSchedule(ScheduleModel scheduleModel) async {
    try {
      state = state.copyWith(status: ScheduleStatus.addingSchedule);
      print(scheduleModel.startOfShift);
      if (state.schedule.where((element) {
            print(
                "${element.startOfShift.withoutTime} - ${scheduleModel.startOfShift.withoutTime}");
            return element.startOfShift.withoutTime ==
                scheduleModel.startOfShift.withoutTime;
          }).length !=
          3) {
        await _repository.addScheduleToFirebase(scheduleModel);
        state = state.copyWith(
          status: ScheduleStatus.addScheduleSuccess,
          schedule: [...state.schedule, scheduleModel],
        );
      } else {
        state = state.copyWith(
            status: ScheduleStatus.addScheduleFailure,
            message: "Maximum 3 Shifts in a day!");
      }
    } on FirebaseException catch (e) {
      state = state.copyWith(
        status: ScheduleStatus.addScheduleFailure,
        message: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: ScheduleStatus.addScheduleFailure,
        message: e.toString(),
      );
    }
  }

  Future<void> fetchScheduleFromServer() async {
    state = state.copyWith(status: ScheduleStatus.fetchingSchedule);
    try {
      final scheduleList = await _repository.fetchScheduleFromDb();
      state = state.copyWith(
        status: ScheduleStatus.fetchingScheduleSuccess,
        schedule: scheduleList,
      );
    } on Exception catch (error) {
      state = state.copyWith(
        status: ScheduleStatus.fetchingScheduleFailure,
        message: error.toString(),
      );
    }
  }
}
