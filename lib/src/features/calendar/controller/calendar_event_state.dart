part of 'calendar_event_controller.dart';

enum CalendarEventStatus {
  initial,
  addingTip,
  addTipSuccess,
  addTipFailure,
  logoutDeleteEvents,
  fetchingEvents,
  fetchingEventsSuccess,
  fetchingEventsFailure,
  deletingTip,
  deleteTipSuccess,
  deleteTipFailure,
}

class CalendarEventState extends Equatable {
  const CalendarEventState({
    this.status = CalendarEventStatus.initial,
    this.tips = const [],
    this.message = "",
    this.calendarEvents = const [],
  });

  final CalendarEventStatus status;
  final List<TipModel> tips;
  final String message;
  final List<CalendarEventData> calendarEvents;

  CalendarEventState copyWith({
    CalendarEventStatus? status,
    List<TipModel>? tips,
    String? message,
    List<CalendarEventData>? calendarEvents,
  }) {
    return CalendarEventState(
      status: status ?? this.status,
      tips: tips ?? this.tips,
      message: message ?? this.message,
      calendarEvents: calendarEvents ?? this.calendarEvents,
    );
  }

  @override
  List<Object?> get props => [status, tips, message, calendarEvents];
}
