import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';

part 'calendar_event_state.dart';

final calendarEventControllerProvider =
    StateNotifierProvider.autoDispose<CalendarEventController, CalendarEventState>(
  (ref) => CalendarEventController(),
);

class CalendarEventController extends StateNotifier<CalendarEventState> {
  CalendarEventController() : super(const CalendarEventState());

  void addCalendarEvent({
    required DateTime dateTime,
    required String eventName,
  }) {
    final event = CalendarEventData(
      date: dateTime,
      title: eventName,
      event: eventName,
    );

    final List<CalendarEventData> events = [...state.events, event];

    state = state.copyWith(
      status: CalendarEventStatus.addEvent,
      events: events,
    );
  }

  void removeCalendarEvent() {}
}
