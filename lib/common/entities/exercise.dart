// To parse this JSON data, do
//
//     final exercise = exerciseFromJson(jsonString);

import 'dart:convert';

List<Exercise> exerciseFromJson(String str) => List<Exercise>.from(json.decode(str).map((x) => Exercise.fromJson(x)));

String exerciseToJson(List<Exercise> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exercise {
    String name;
    int caloriesPerHour;
    int durationMinutes;
    int totalCalories;

    Exercise({
        required this.name,
        required this.caloriesPerHour,
        required this.durationMinutes,
        required this.totalCalories,
    });

    factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        caloriesPerHour: json["calories_per_hour"],
        durationMinutes: json["duration_minutes"],
        totalCalories: json["total_calories"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "calories_per_hour": caloriesPerHour,
        "duration_minutes": durationMinutes,
        "total_calories": totalCalories,
    };
}
