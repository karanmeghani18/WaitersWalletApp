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

    final List<TipModel> tips = [...state.tips, tipModel];
    final List<CalendarEventData> events = [...state.calendarEvents, event];

    String errorText = await _repository.addTipToFirebase(tipModel);

    if (errorText.isEmpty) {
      state = state.copyWith(
        status: CalendarEventStatus.addTipSuccess,
        tips: tips,
        calendarEvents: events,
      );
    } else {
      state = state.copyWith(
        status: CalendarEventStatus.addTipFailure,
        message: errorText,
      );
    }
  }

  Future<void> editCalendarEvent({required TipModel tipModel}) async {
    state = state.copyWith(status: CalendarEventStatus.editingTip);

    final List<TipModel> tips = state.tips;
    List<CalendarEventData> events = state.calendarEvents;
    tips.removeWhere((element) => element.id == tipModel.id);
    events.removeWhere((element) => element.event == tipModel.id);

    final event = CalendarEventData(
      date: tipModel.fullDateTime,
      title: tipModel.tipAmount.toString(),
      event: tipModel.id,
    );

    String errorText = await _repository.addTipToFirebase(tipModel);

    if (errorText.isEmpty) {
      state = state.copyWith(
        status: CalendarEventStatus.editTipSuccess,
        tips: [...tips, tipModel],
        calendarEvents: [...events, event],
      );
    } else {
      state = state.copyWith(
        status: CalendarEventStatus.editTipFailure,
        message: errorText,
      );
    }
  }

  Future<void> fetchTipsFromServer() async {
    state = state.copyWith(status: CalendarEventStatus.fetchingEvents);

    try {
      final tipsList = await _repository.fetchExistingTips();
      List<CalendarEventData> eventsList = [];
      for (TipModel tipModel in tipsList) {
        final event = CalendarEventData(
          date: tipModel.fullDateTime,
          title: tipModel.tipAmount.toString(),
          event: tipModel.id,
        );
        eventsList.add(event);
      }

      state = state.copyWith(
        status: CalendarEventStatus.fetchingEventsSuccess,
        tips: tipsList,
        calendarEvents: eventsList,
      );
    } on Exception catch (error) {
      state = state.copyWith(
        status: CalendarEventStatus.fetchingEventsFailure,
        message: error.toString(),
      );
    }
  }

  void removeAllEvents() {
    state = state.copyWith(
      calendarEvents: [],
      tips: [],
      status: CalendarEventStatus.logoutDeleteEvents,
    );
  }

  Future<void> deleteTip(String tipId) async {
    state = state.copyWith(status: CalendarEventStatus.deletingTip);
    try {
      await _repository.deleteTip(tipId);
      List<TipModel> updatedTips = state.tips;
      List<CalendarEventData> calendarEvents = state.calendarEvents;
      updatedTips.removeWhere((element) => element.id == tipId);
      calendarEvents.removeWhere((element) => element.event == tipId);
      state = state.copyWith(
        tips: updatedTips,
        calendarEvents: calendarEvents,
        status: CalendarEventStatus.deleteTipSuccess,
      );
    } catch (e) {
      state = state.copyWith(
        status: CalendarEventStatus.deleteTipFailure,
        message: e.toString(),
      );
    }
  }

  // List<double> getWeekEarningsData(int subtract, int add) {
  //   DateTime now = DateTime.now();
  //   DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  //   startOfWeek = startOfWeek.subtract(Duration(days: subtract));
  //   startOfWeek = startOfWeek.add(Duration(days: add));
  //   DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));
  //
  //   List<double> tipAmounts = [];
  //
  //   for (DateTime date = startOfWeek;
  //       date.isBefore(endOfWeek);
  //       date = date.add(const Duration(days: 1))) {
  //     List<double> dailyTipAmounts = [];
  //
  //     for (TipModel tip in state.tips) {
  //       DateTime datetime = tip.fullDateTime;
  //
  //       if (datetime.year == date.year &&
  //           datetime.month == date.month &&
  //           datetime.day == date.day) {
  //         dailyTipAmounts.add(tip.tipAmount);
  //       }
  //     }
  //
  //     double tipAmount = dailyTipAmounts.isNotEmpty
  //         ? dailyTipAmounts.reduce((a, b) => a + b)
  //         : 0.0;
  //     tipAmounts.add(tipAmount);
  //   }
  //
  //   return tipAmounts;
  // }

  List<double> getWeekEarningsData(int subtract, int add) {
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    startOfWeek =
        startOfWeek.subtract(Duration(days: subtract * 7)); // Subtract weeks
    startOfWeek = startOfWeek.add(Duration(days: add * 7)); // Add weeks
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));

    List<double> tipAmounts = [];

    for (DateTime date = startOfWeek;
        date.isBefore(endOfWeek);
        date = date.add(const Duration(days: 1))) {
      List<double> dailyTipAmounts = [];

      for (TipModel tip in state.tips) {
        DateTime datetime = tip.fullDateTime;

        if (datetime.year == date.year &&
            datetime.month == date.month &&
            datetime.day == date.day) {
          dailyTipAmounts.add(tip.tipAmount);
        }
      }

      double tipAmount = dailyTipAmounts.isNotEmpty
          ? dailyTipAmounts.reduce((a, b) => a + b)
          : 0.0;
      tipAmounts.add(tipAmount);
    }

    return tipAmounts;
  }

  List<double> getMonthEarningsData(DateTime targetDate) {
    Map<String, List<double>> tipAmountsByMonth = {};

    for (TipModel tip in state.tips) {
      DateTime datetime = tip.fullDateTime;
      double tipAmount = tip.tipAmount;

      String monthYear = '${datetime.year}-${datetime.month}';

      if (tipAmountsByMonth.containsKey(monthYear)) {
        tipAmountsByMonth[monthYear]!.add(tipAmount);
      } else {
        tipAmountsByMonth[monthYear] = [tipAmount];
      }
    }

    List<double> tipAmounts = [];

    DateTime currentDate = targetDate;
    for (int i = 1; i <= 12; i++) {
      String monthYear = '${currentDate.year}-$i';
      List<double> monthTipAmounts = tipAmountsByMonth[monthYear] ?? [];
      double totalTipAmount = monthTipAmounts.isNotEmpty
          ? monthTipAmounts.reduce((a, b) => a + b)
          : 0.0;
      tipAmounts.add(totalTipAmount);
    }

    return tipAmounts;
  }
}
