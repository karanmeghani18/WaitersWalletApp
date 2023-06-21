class TipModel {
  final String id;
  final DateTime fullDateTime;
  final double tipAmount;
  final double hoursWorked;
  final String notes;
  final int restaurantId;

  TipModel({
    required this.fullDateTime,
    required this.tipAmount,
    required this.hoursWorked,
    required this.restaurantId,
    this.notes = "",
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullDateTime": fullDateTime.toIso8601String(),
      "tipAmount": tipAmount,
      "hoursWorked": hoursWorked,
      "notes": notes,
      "restaurantId": restaurantId,
    };
  }

  TipModel fromJson(Map<String, dynamic> json) {
    return TipModel(
      fullDateTime: DateTime(json["fullDateTime"]),
      tipAmount: double.parse(json["tipAmount"]),
      hoursWorked: double.parse(json["hoursWorked"]),
      restaurantId: int.parse(json["restaurantId"]),
      notes: json["notes"],
      id: json["id"],
    );
  }
}
