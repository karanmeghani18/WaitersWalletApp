part of 'earnings_controller.dart';

enum EarningsStatus {
  initial,
}

class EarningsState extends Equatable {
  const EarningsState({
    this.status = EarningsStatus.initial,
    this.message = "",
  });

  final EarningsStatus status;
  final String message;

  EarningsState copyWith({
    EarningsStatus? status,
    String? message,
  }) {
    return EarningsState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
