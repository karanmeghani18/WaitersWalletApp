import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/repository/calendar_repo.dart';

part 'earnings_state.dart';

final earningsControllerProvider =
    StateNotifierProvider.autoDispose<EarningsController, EarningsState>(
  (ref) => EarningsController(
    repository: ref.read(calendarRepoProvider),
  ),
);

class EarningsController extends StateNotifier<EarningsState> {
  EarningsController({
    required CalendarRepository repository,
  })  : _repository = repository,
        super(const EarningsState());
  final CalendarRepository _repository;

  void fetchWeekData(){

  }
}
