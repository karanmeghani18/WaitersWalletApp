import 'package:waiters_wallet/src/features/addtip/models/restaurant_model.dart';

class WalletUser {
  final String fullName;
  final String email;
  final List<RestaurantModel> restaurants;

  const WalletUser({
    required this.fullName,
    required this.email,
    required this.restaurants,
  });

  static WalletUser fromJson(Map<String, dynamic> json) {
    return WalletUser(
      fullName: json["full_name"],
      email: json["email"],
      restaurants: [],
    );
  }

  WalletUser copyWith({
    String? fullName,
    String? email,
    List<RestaurantModel>? restaurants,
  }) {
    return WalletUser(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      restaurants: restaurants ?? this.restaurants,
    );
  }
}
