import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';
import 'package:waiters_wallet/src/features/calendar/repository/calendar_repo.dart';

part 'calendar_event_state.dart';

final calendarEventControllerProvider = StateNotifierProvider.autoDispose<
    CalendarEventController, CalendarEventState>(
  (ref) => CalendarEventController(
    repository: ref.read(calendarRepoProvider)
  ),
);

class CalendarEventController extends StateNotifier<CalendarEventState> {
  CalendarEventController({
    required CalendarRepository repository,
  })  : _repository = repository,
        super(const CalendarEventState());
  final CalendarRepository _repository;

  EventController eventController = EventController();

  void addCalendarEvent(
      {required DateTime dateTime,
      required String eventName,
      required String title}) {
    final event = CalendarEventData(
      date: dateTime,
      title: title,
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
