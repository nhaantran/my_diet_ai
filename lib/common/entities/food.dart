// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    String name;
    double calories;
    double servingSizeG;
    double fatTotalG;
    double? fatSaturatedG;
    double proteinG;
    int? sodiumMg;
    int? potassiumMg;
    int? cholesterolMg;
    double carbohydratesTotalG;
    double? fiberG;
    double? sugarG;

    Food({
        required this.name,
        required this.calories,
        required this.servingSizeG,
        required this.fatTotalG,
        this.fatSaturatedG,
        required this.proteinG,
        this.sodiumMg,
        this.potassiumMg,
        this.cholesterolMg,
        required this.carbohydratesTotalG,
        this.fiberG,
        this.sugarG,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        name: json["name"],
        calories: json["calories"] is String ? double.tryParse(json["calories"]) ?? 0.0 : json["calories"]?.toDouble(),
    servingSizeG: json["serving_size_g"] is String ? double.tryParse(json["serving_size_g"]) ?? 0.0 : json["serving_size_g"]?.toDouble(),
    fatTotalG: json["fat_total_g"] is String ? double.tryParse(json["fat_total_g"]) ?? 0.0 : json["fat_total_g"]?.toDouble(),
    fatSaturatedG: json["fat_saturated_g"] is String ? double.tryParse(json["fat_saturated_g"]) ?? 0.0 : json["fat_saturated_g"]?.toDouble(),
    proteinG: json["protein_g"] is String ? double.tryParse(json["protein_g"]) ?? 0.0 : json["protein_g"]?.toDouble(),
    sodiumMg: json["sodium_mg"],
    potassiumMg: json["potassium_mg"],
    cholesterolMg: json["cholesterol_mg"],
    carbohydratesTotalG: json["carbohydrates_total_g"] is String ? double.tryParse(json["carbohydrates_total_g"]) ?? 0.0 : json["carbohydrates_total_g"]?.toDouble(),
    fiberG: json["fiber_g"] is String ? double.tryParse(json["fiber_g"]) ?? 0.0 : json["fiber_g"]?.toDouble(),
    sugarG: json["sugar_g"] is String ? double.tryParse(json["sugar_g"]) ?? 0.0 : json["sugar_g"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "calories": calories,
        "serving_size_g": servingSizeG,
        "fat_total_g": fatTotalG,
        "fat_saturated_g": fatSaturatedG,
        "protein_g": proteinG,
        "sodium_mg": sodiumMg,
        "potassium_mg": potassiumMg,
        "cholesterol_mg": cholesterolMg,
        "carbohydrates_total_g": carbohydratesTotalG,
        "fiber_g": fiberG,
        "sugar_g": sugarG,
    };
}
