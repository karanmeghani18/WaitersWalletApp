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

  static TipModel fromJson(Map<String, dynamic> json, String id) {
    return TipModel(
      fullDateTime: DateTime.parse(json["fullDateTime"]),
      tipAmount: json["tipAmount"],
      hoursWorked: json["hoursWorked"],
      restaurantId: json["restaurantId"],
      notes: json["notes"],
      id: id,
    );
  }

  @override
  String toString() {
    return 'TipModel{id: $id, fullDateTime: $fullDateTime, tipAmount: $tipAmount, hoursWorked: $hoursWorked, notes: $notes, restaurantId: $restaurantId}';
  }
}
