import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:waiters_wallet/src/features/calendar/repository/calendar_repo.dart';

part 'addtip_state.dart';

final addTipControllerProvider =
    StateNotifierProvider.autoDispose<AddTipController, AddTipState>(
  (ref) => AddTipController(
    repository: ref.read(calendarRepoProvider),
  ),
);

class AddTipController extends StateNotifier<AddTipState> {
  AddTipController({
    required CalendarRepository repository,
  })  : _repository = repository,
        super(const AddTipState());
  final CalendarRepository _repository;
}
