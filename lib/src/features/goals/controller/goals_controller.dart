import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';

import '../repo/goals_repository.dart';

part 'goals_state.dart';

final goalsControllerProvider =
StateNotifierProvider.autoDispose<GoalsController, GoalsState>(
      (ref) => GoalsController(
    repository: ref.read(
      goalsRepoProvider,
    ),
  ),
);

class GoalsController extends StateNotifier<GoalsState> {
  GoalsController({
    required GoalsRepo repository,
  })  : _repository = repository,
        super(const GoalsState());
  final GoalsRepo _repository;

  Future<void> addGoals(GoalsModel goalsModel) async {
    try {
      state = state.copyWith(status: GoalsStatus.addingGoals);
      state = state.copyWith(status: GoalsStatus.addGoalsSuccess);

    } on FirebaseException catch (e) {
      state = state.copyWith(
        status: GoalsStatus.addGoalsFailure,
        message: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        status: GoalsStatus.addGoalsFailure,
        message: e.toString(),
      );
    }
  }

  Future<void> fetchGoalsFromServer() async {
    state = state.copyWith(status: GoalsStatus.fetchingGoals);
    try {
      state = state.copyWith(
        status: GoalsStatus.fetchingGoalsSuccess
      );
    } on Exception catch (error) {
      state = state.copyWith(
        status: GoalsStatus.fetchingGoalsFailure,
        message: error.toString(),
      );
    }
  }
}
