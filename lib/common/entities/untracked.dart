// To parse this JSON data, do
//
//     final untracked = untrackedFromJson(jsonString);

import 'dart:convert';

UntrackedFood untrackedFoodFromJson(String str) =>
    UntrackedFood.fromJson(json.decode(str));

String untrackedFoodToJson(UntrackedFood data) => json.encode(data.toJson());

class UntrackedFood {
  String description;
  double calories;

  UntrackedFood({
    required this.description,
    required this.calories,
  });

  factory UntrackedFood.fromJson(Map<String, dynamic> json) => UntrackedFood(
        description: json["description"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "calories": calories,
      };
}

UntrackedExercise untrackedExerciseFromJson(String str) =>
    UntrackedExercise.fromJson(json.decode(str));

String untrackedExerciseToJson(UntrackedExercise data) =>
    json.encode(data.toJson());

class UntrackedExercise {
  String description;
  int duration;
  int calories;

  UntrackedExercise({
    required this.description,
    required this.duration,
    required this.calories,
  });

  factory UntrackedExercise.fromJson(Map<String, dynamic> json) =>
      UntrackedExercise(
        description: json["description"],
        duration: json["duration"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "duration": duration,
        "calories": calories,
      };
}
