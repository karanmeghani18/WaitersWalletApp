part of 'addrestaurant_controller.dart';

enum AddRestaurantStatus {
  initial,
  addingRestaurant,
  addingRestaurantSuccess,
  addingRestaurantFailure,
  deletingRestaurant,
  deletingRestaurantSuccess,
  deletingRestaurantFailure,
}

class AddRestaurantState extends Equatable {
  const AddRestaurantState({
    this.status = AddRestaurantStatus.initial,
    this.errorText = "",
  });

  final AddRestaurantStatus status;
  final String errorText;

  AddRestaurantState copyWith({
    AddRestaurantStatus? status,
    String? message,
  }) {
    return AddRestaurantState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}
