// To parse this JSON data, do
//
//     final searchingFood = searchingFoodFromJson(jsonString);

import 'dart:convert';

SearchingFood searchingFoodFromJson(String str) =>
    SearchingFood.fromJson(json.decode(str));

String searchingFoodToJson(SearchingFood data) => json.encode(data.toJson());

class SearchingFood {
  List<Result>? results;
  int? offset;
  int? number;
  int? totalResults;

  SearchingFood({
    this.results,
    this.offset,
    this.number,
    this.totalResults,
  });

  factory SearchingFood.fromJson(Map<String, dynamic> json) => SearchingFood(
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        offset: json["offset"],
        number: json["number"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "offset": offset,
        "number": number,
        "totalResults": totalResults,
      };
}

class Result {
  int? id;
  String? title;
  String? image;
  ImageType? imageType;
  Nutrition? nutrition;

  Result({
    this.id,
    this.title,
    this.image,
    this.imageType,
    this.nutrition,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imageType: imageTypeValues.map[json["imageType"]],
        nutrition: json["nutrition"] == null
            ? null
            : Nutrition.fromJson(json["nutrition"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imageType": imageTypeValues.reverse[imageType],
        "nutrition": nutrition?.toJson(),
      };
}

enum ImageType { JPG }

final imageTypeValues = EnumValues({"jpg": ImageType.JPG});

class Nutrition {
  List<Nutrient>? nutrients;

  Nutrition({
    this.nutrients,
  });

  factory Nutrition.fromJson(Map<String, dynamic> json) => Nutrition(
        nutrients: json["nutrients"] == null
            ? []
            : List<Nutrient>.from(
                json["nutrients"]!.map((x) => Nutrient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nutrients": nutrients == null
            ? []
            : List<dynamic>.from(nutrients!.map((x) => x.toJson())),
      };
}

class Nutrient {
  String? name;
  double? amount;
  Unit? unit;

  Nutrient({
    this.name,
    this.amount,
    this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        name: json["name"],
        amount: json["amount"]?.toDouble(),
        unit: unitValues.map[json["unit"]]!,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "unit": unitValues.reverse[unit],
      };
}

enum Unit { G, MG, IU, UNIT_G, KCAL }

final unitValues = EnumValues({
  "g": Unit.G,
  "IU": Unit.IU,
  "kcal": Unit.KCAL,
  "mg": Unit.MG,
  "µg": Unit.UNIT_G
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
