class TipModel {
  final String id;
  final DateTime fullDateTime;
  final double tipAmount;
  final double hoursWorked;
  final String notes;
  final String restaurantId;
  final double salesAmount;
  final double takeHome;
  final double barTipOutAmount;
  final double bohTipOutAmount;

  TipModel({
    required this.fullDateTime,
    required this.tipAmount,
    required this.hoursWorked,
    required this.restaurantId,
    this.notes = "",
    required this.id,
    required this.salesAmount,
    this.barTipOutAmount = 0.0,
    this.takeHome = 0.0,
    this.bohTipOutAmount = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullDateTime": fullDateTime.toIso8601String(),
      "tipAmount": tipAmount,
      "hoursWorked": hoursWorked,
      "notes": notes,
      "restaurantId": restaurantId,
      "salesAmount": salesAmount,
      "takeHome": takeHome,
      "barTipOutAmount": barTipOutAmount,
      "bohTipOutAmount": bohTipOutAmount,
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
      salesAmount: json["salesAmount"],
      takeHome: json["takeHome"],
      barTipOutAmount: json["barTipOutAmount"],
      bohTipOutAmount: json["bohTipOutAmount"],
    );
  }

  @override
  String toString() {
    return 'TipModel{id: $id, fullDateTime: $fullDateTime, tipAmount: $tipAmount, hoursWorked: $hoursWorked, notes: $notes, restaurantId: $restaurantId}';
  }
}
