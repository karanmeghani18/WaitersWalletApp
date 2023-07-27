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
    state = state.copyWith(status: GoalsStatus.addingGoals);
    try {
      await _repository.addGoalsToFirebase(goalsModel);
      state = state.copyWith(
        status: GoalsStatus.addGoalsSuccess,
        goals: goalsModel,
      );
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

  void setGoalsFromServer(GoalsModel goalsModel) async {
    state = state.copyWith(goals: goalsModel);
  }
}
