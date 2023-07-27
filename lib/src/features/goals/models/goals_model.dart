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
      averageHourlyGoal: json['averageHourlyGoal'],
      hoursGoal: json['hoursGoal'],
      takeHomeGoal: json['takeHomeGoal'],
      goalType: GoalType.values[json['goalType']],
    );
  }
}
