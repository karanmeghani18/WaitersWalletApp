part of 'schedule_controller.dart';

enum ScheduleStatus {
  initial,
  addingSchedule,
  addScheduleSuccess,
  addScheduleFailure,
  fetchingSchedule,
  fetchingScheduleSuccess,
  fetchingScheduleFailure,
}

class ScheduleState extends Equatable {
  const ScheduleState({
    this.status = ScheduleStatus.initial,
    this.schedule = const [],
    this.message = "",
  });

  final ScheduleStatus status;
  final List<ScheduleModel> schedule;
  final String message;

  ScheduleState copyWith({
    ScheduleStatus? status,
    List<ScheduleModel>? schedule,
    String? message,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      schedule: schedule ?? this.schedule,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, schedule, message];
}
