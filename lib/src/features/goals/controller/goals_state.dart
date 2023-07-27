part of 'goals_controller.dart';

enum GoalsStatus {
  initial,
  addingGoals,
  addGoalsSuccess,
  addGoalsFailure,
  fetchingGoals,
  fetchingGoalsSuccess,
  fetchingGoalsFailure,
}

class GoalsState extends Equatable {
  const GoalsState({
    this.status = GoalsStatus.initial,
    this.goals = const [],
    this.message = "",
  });

  final GoalsStatus status;
  final List goals;
  final String message;

  GoalsState copyWith({
    GoalsStatus? status,
    List? goals,
    String? message,
  }) {
    return GoalsState(
      status: status ?? this.status,
      goals: goals ?? this.goals,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, goals, message];
}
