// To parse this JSON data, do
//
//     final customerData = customerDataFromJson(jsonString);

import 'dart:convert';

CustomerData customerDataFromJson(String str) =>
    CustomerData.fromJson(json.decode(str));

String customerDataToJson(CustomerData data) => json.encode(data.toJson());

class CustomerData {
  String height;
  String weight;
  String age;
  String gender;
  String exercise;
  String goalWeight;
  String goal;
  BodyMassIndex bodyMassIndex;
  BodyFatPercentage bodyFatPercentage;
  BodyFatPercentage leanBodyMass;
  RestingDailyEnergyExpenditure restingDailyEnergyExpenditure;
  BasalMetabolicRate basalMetabolicRate;
  BasalMetabolicRate totalDailyEnergyExpenditure;
  IdealBodyWeight idealBodyWeight;

  CustomerData({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    required this.exercise,
    required this.goalWeight,
    required this.goal,
    required this.bodyMassIndex,
    required this.bodyFatPercentage,
    required this.leanBodyMass,
    required this.restingDailyEnergyExpenditure,
    required this.basalMetabolicRate,
    required this.totalDailyEnergyExpenditure,
    required this.idealBodyWeight,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        height: json["height"],
        weight: json["weight"],
        age: json["age"],
        gender: json["gender"],
        exercise: json["exercise"],
        goalWeight: json["goalWeight"],
        goal: json["goal"],
        bodyMassIndex: BodyMassIndex.fromJson(json["bodyMassIndex"]),
        bodyFatPercentage:
            BodyFatPercentage.fromJson(json["bodyFatPercentage"]),
        leanBodyMass: BodyFatPercentage.fromJson(json["leanBodyMass"]),
        restingDailyEnergyExpenditure: RestingDailyEnergyExpenditure.fromJson(
            json["restingDailyEnergyExpenditure"]),
        basalMetabolicRate:
            BasalMetabolicRate.fromJson(json["basalMetabolicRate"]),
        totalDailyEnergyExpenditure:
            BasalMetabolicRate.fromJson(json["totalDailyEnergyExpenditure"]),
        idealBodyWeight: IdealBodyWeight.fromJson(json["idealBodyWeight"]),
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "weight": weight,
        "age": age,
        "gender": gender,
        "exercise": exercise,
        "goalWeight": goalWeight,
        "goal": goal,
        "bodyMassIndex": bodyMassIndex.toJson(),
        "bodyFatPercentage": bodyFatPercentage.toJson(),
        "leanBodyMass": leanBodyMass.toJson(),
        "restingDailyEnergyExpenditure": restingDailyEnergyExpenditure.toJson(),
        "basalMetabolicRate": basalMetabolicRate.toJson(),
        "totalDailyEnergyExpenditure": totalDailyEnergyExpenditure.toJson(),
        "idealBodyWeight": idealBodyWeight.toJson(),
      };
}

class BasalMetabolicRate {
  Hb hb;
  Hb rs;
  Hb msj;
  Hb? bmi;

  BasalMetabolicRate({
    required this.hb,
    required this.rs,
    required this.msj,
    this.bmi,
  });

  factory BasalMetabolicRate.fromJson(Map<String, dynamic> json) =>
      BasalMetabolicRate(
        hb: Hb.fromJson(json["hb"]),
        rs: Hb.fromJson(json["rs"]),
        msj: Hb.fromJson(json["msj"]),
        bmi: json["bmi"] == null ? null : Hb.fromJson(json["bmi"]),
      );

  Map<String, dynamic> toJson() => {
        "hb": hb.toJson(),
        "rs": rs.toJson(),
        "msj": msj.toJson(),
        "bmi": bmi?.toJson(),
      };
}

class Hb {
  String formulaName;
  Calories calories;
  Calories joules;

  Hb({
    required this.formulaName,
    required this.calories,
    required this.joules,
  });

  factory Hb.fromJson(Map<String, dynamic> json) => Hb(
        formulaName: json["formulaName"],
        calories: Calories.fromJson(json["calories"]),
        joules: Calories.fromJson(json["joules"]),
      );

  Map<String, dynamic> toJson() => {
        "formulaName": formulaName,
        "calories": calories.toJson(),
        "joules": joules.toJson(),
      };
}

class Calories {
  double value;
  List<String> unit;

  Calories({
    required this.value,
    required this.unit,
  });

  factory Calories.fromJson(Map<String, dynamic> json) => Calories(
        value: json["value"]?.toDouble(),
        unit: List<String>.from(json["unit"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "unit": List<dynamic>.from(unit.map((x) => x)),
      };
}

class BodyFatPercentage {
  Bmi bmi;

  BodyFatPercentage({
    required this.bmi,
  });

  factory BodyFatPercentage.fromJson(Map<String, dynamic> json) =>
      BodyFatPercentage(
        bmi: Bmi.fromJson(json["bmi"]),
      );

  Map<String, dynamic> toJson() => {
        "bmi": bmi.toJson(),
      };
}

class Bmi {
  String formulaName;
  double value;
  String? conclusion;
  List<String> unit;

  Bmi({
    required this.formulaName,
    required this.value,
    this.conclusion,
    required this.unit,
  });

  factory Bmi.fromJson(Map<String, dynamic> json) => Bmi(
        formulaName: json["formulaName"],
        value: json["value"]?.toDouble(),
        conclusion: json["conclusion"],
        unit: List<String>.from(json["unit"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "formulaName": formulaName,
        "value": value,
        "conclusion": conclusion,
        "unit": List<dynamic>.from(unit.map((x) => x)),
      };
}

class BodyMassIndex {
  double value;
  String conclusion;
  String unit;

  BodyMassIndex({
    required this.value,
    required this.conclusion,
    required this.unit,
  });

  factory BodyMassIndex.fromJson(Map<String, dynamic> json) => BodyMassIndex(
        value: json["value"]?.toDouble(),
        conclusion: json["conclusion"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "conclusion": conclusion,
        "unit": unit,
      };
}

class IdealBodyWeight {
  Devine peterson;
  Devine lorentz;
  Devine hamwi;
  Devine devine;
  Devine robinson;
  Devine miller;

  IdealBodyWeight({
    required this.peterson,
    required this.lorentz,
    required this.hamwi,
    required this.devine,
    required this.robinson,
    required this.miller,
  });

  factory IdealBodyWeight.fromJson(Map<String, dynamic> json) =>
      IdealBodyWeight(
        peterson: Devine.fromJson(json["peterson"]),
        lorentz: Devine.fromJson(json["lorentz"]),
        hamwi: Devine.fromJson(json["hamwi"]),
        devine: Devine.fromJson(json["devine"]),
        robinson: Devine.fromJson(json["robinson"]),
        miller: Devine.fromJson(json["miller"]),
      );

  Map<String, dynamic> toJson() => {
        "peterson": peterson.toJson(),
        "lorentz": lorentz.toJson(),
        "hamwi": hamwi.toJson(),
        "devine": devine.toJson(),
        "robinson": robinson.toJson(),
        "miller": miller.toJson(),
      };
}

class Devine {
  String formulaName;
  Calories metric;
  Calories imperial;

  Devine({
    required this.formulaName,
    required this.metric,
    required this.imperial,
  });

  factory Devine.fromJson(Map<String, dynamic> json) => Devine(
        formulaName: json["formulaName"],
        metric: Calories.fromJson(json["metric"]),
        imperial: Calories.fromJson(json["imperial"]),
      );

  Map<String, dynamic> toJson() => {
        "formulaName": formulaName,
        "metric": metric.toJson(),
        "imperial": imperial.toJson(),
      };
}

class RestingDailyEnergyExpenditure {
  Hb bmi;

  RestingDailyEnergyExpenditure({
    required this.bmi,
  });

  factory RestingDailyEnergyExpenditure.fromJson(Map<String, dynamic> json) =>
      RestingDailyEnergyExpenditure(
        bmi: Hb.fromJson(json["bmi"]),
      );

  Map<String, dynamic> toJson() => {
        "bmi": bmi.toJson(),
      };
}
