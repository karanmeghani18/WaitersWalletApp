part of 'calendar_event_controller.dart';

enum CalendarEventStatus {
  initial,
  addingTip,
  addTipSuccess,
  addTipFailure,
  logoutDeleteEvents,
}

class CalendarEventState extends Equatable {
  const CalendarEventState({
    this.status = CalendarEventStatus.initial,
    this.events = const [],
    this.message = "",
  });

  final CalendarEventStatus status;
  final List<CalendarEventData> events;
  final String message;

  CalendarEventState copyWith({
    CalendarEventStatus? status,
    List<CalendarEventData>? events,
    String? message,
  }) {
    return CalendarEventState(
      status: status ?? this.status,
      events: events ?? this.events,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, events, message];
}
