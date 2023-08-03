enum GoalType {weekly, monthly}

class GoalsModel {
  final double takeHomeGoal;
  final double hoursGoal;
  final double averageHourlyGoal;
  final GoalType goalType;

  const GoalsModel({
    required this.averageHourlyGoal,
    required this.hoursGoal,
    required this.takeHomeGoal,
    required this.goalType
  });

  Map<String, dynamic> toJson() {
    return {
      "takeHomeGoal": takeHomeGoal,
      "hoursGoal": hoursGoal,
      "averageHourlyGoal": averageHourlyGoal,
      "goalType": goalType.index,
    };
  }

  static GoalsModel fromJson(Map<String, dynamic> json) {
    return GoalsModel(
      averageHourlyGoal: json['averageHourlyGoal'] ?? 0.0,
      hoursGoal: json['hoursGoal'] ?? 0.0,
      takeHomeGoal: json['takeHomeGoal'] ?? 0.0,
      goalType: GoalType.values[json['goalType'] ?? 0],
    );
  }
}
