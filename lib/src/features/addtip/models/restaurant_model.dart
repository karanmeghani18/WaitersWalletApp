class RestaurantModel {
  final String restaurantName;
  final double barTipOut;
  final double bohTipOut;
  final String id;

  RestaurantModel({
    required this.restaurantName,
    required this.barTipOut,
    required this.bohTipOut,
    required this.id,
  });

  static RestaurantModel fromJson(Map<String, dynamic> json, String id) {
    return RestaurantModel(
      restaurantName: json["restaurantName"],
      barTipOut: json["barTipOut"],
      bohTipOut: json["bohTipOut"],
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "restaurantName": restaurantName,
      "barTipOut": barTipOut,
      "bohTipOut": bohTipOut,
    };
  }
}
