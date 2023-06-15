part of 'calendar_event_controller.dart';

enum CalendarEventStatus {
  initial,
  fetchingEvents,
  fetchEventsSuccess,
  fetchEventsFailure,
  addEvent,
}

class CalendarEventState extends Equatable {
  const CalendarEventState({
    this.status = CalendarEventStatus.initial,
    this.events = const [],
  });

  final CalendarEventStatus status;
  final List<CalendarEventData> events;

  CalendarEventState copyWith({
    CalendarEventStatus? status,
    List<CalendarEventData>? events,
  }) {
    return CalendarEventState(
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [status, events];
}
