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
      restaurants:
          json["restaurants"] != null ? List.from(json["restaurants"]) : [],
    );
  }
}
