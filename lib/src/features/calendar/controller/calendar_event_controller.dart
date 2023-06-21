import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';
import 'package:waiters_wallet/src/features/addtip/models/tip_model.dart';
import 'package:waiters_wallet/src/features/calendar/repository/calendar_repo.dart';

part 'calendar_event_state.dart';

final calendarEventControllerProvider = StateNotifierProvider.autoDispose<
    CalendarEventController, CalendarEventState>(
  (ref) => CalendarEventController(repository: ref.read(calendarRepoProvider)),
);

class CalendarEventController extends StateNotifier<CalendarEventState> {
  CalendarEventController({
    required CalendarRepository repository,
  })  : _repository = repository,
        super(const CalendarEventState());
  final CalendarRepository _repository;

  EventController eventController = EventController();

  Future<void> addCalendarEvent({required TipModel tipModel}) async {
    state = state.copyWith(status: CalendarEventStatus.addingTip);

    final event = CalendarEventData(
      date: tipModel.fullDateTime,
      title: tipModel.tipAmount.toString(),
      event: tipModel.id,
    );

    final List<CalendarEventData> events = [...state.events, event];

    String errorText = await _repository.addTipToFirebase(
      tipModel,
      tipModel.id,
    );

    if (errorText.isEmpty) {
      state = state.copyWith(
        status: CalendarEventStatus.addTipSuccess,
        events: events,
      );
    } else {
      state = state.copyWith(
        status: CalendarEventStatus.addTipFailure,
        events: events,
        message: errorText,
      );
    }
  }

  void removeAllEvents() {
    state = state.copyWith(
      events: [],
      status: CalendarEventStatus.logoutDeleteEvents,
    );
  }
}
