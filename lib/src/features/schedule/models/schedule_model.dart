
class ScheduleModel {
  DateTime startOfShift;
  DateTime endOfShift;
  String restaurantId;
  String id;
  String restaurantName;

  ScheduleModel({
    required this.id,
    required this.startOfShift,
    required this.endOfShift,
    required this.restaurantId,
    required this.restaurantName,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "startOfShift": startOfShift.toIso8601String(),
      "endOfShift": endOfShift.toIso8601String(),
      "restaurantId": restaurantId,
      "restaurantName": restaurantName,
    };
  }

  static ScheduleModel fromJson(Map<String, dynamic> json, String id) {
    return ScheduleModel(
      id: id,
      restaurantName: json['restaurantName'],
      startOfShift: DateTime.parse(json['startOfShift']),
      endOfShift: DateTime.parse(json['endOfShift']),
      restaurantId: json['restaurantId'],
    );
  }
}
