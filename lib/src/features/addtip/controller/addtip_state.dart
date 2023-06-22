part of 'addtip_controller.dart';

enum AddTipStatus { initial, addingTip, addingTipSuccess, addingTipFailure }

class AddTipState extends Equatable {
  const AddTipState({
    this.status = AddTipStatus.initial,
    this.errorText = "",
  });

  final AddTipStatus status;
  final String errorText;

  @override
  List<Object?> get props => [status, errorText];
}
