import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';
import 'package:waiters_wallet/src/features/goals/models/goals_model.dart';

class WalletUser {
  final String fullName;
  final String email;
  final List<RestaurantModel> restaurants;
  final GoalsModel? goals;

  const WalletUser({
    required this.fullName,
    required this.email,
    required this.restaurants,
    this.goals,
  });

  static WalletUser fromJson(Map<String, dynamic> json) {
    return WalletUser(
      fullName: json["full_name"],
      email: json["email"],
      restaurants: [],
      goals: GoalsModel.fromJson(json),
    );
  }

  WalletUser copyWith({
    String? fullName,
    String? email,
    List<RestaurantModel>? restaurants,
    GoalsModel? goals,
  }) {
    return WalletUser(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      restaurants: restaurants ?? this.restaurants,
      goals: goals ?? this.goals,
    );
  }
}
