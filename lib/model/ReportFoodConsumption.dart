// To parse this JSON data, do
//
//     final reportFoodConsumption = reportFoodConsumptionFromJson(jsonString);

import 'dart:convert';

ReportFoodConsumption reportFoodConsumptionFromJson(String str) => ReportFoodConsumption.fromJson(json.decode(str));

String reportFoodConsumptionToJson(ReportFoodConsumption data) => json.encode(data.toJson());

class ReportFoodConsumption {
  ReportFoodConsumption({
    this.cattleCount,
    this.data,
  });

  int? cattleCount;
  List<Datum>? data;

  factory ReportFoodConsumption.fromJson(Map<String, dynamic> json) => ReportFoodConsumption(
    cattleCount: json["cattle_count"] == null ? null : json["cattle_count"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cattle_count": cattleCount == null ? null : cattleCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.sl,
    this.farmId,
    this.cattleId,
    this.date,
    this.hasConsumedFood,
    this.hasMeasuredWeight,
  });

  int? sl;
  int? farmId;
  int? cattleId;
  String? date;
  bool? hasConsumedFood;
  bool? hasMeasuredWeight;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sl: json["sl"] == null ? null : json["sl"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    date: json["date"] == null ? null : json["date"],
    hasConsumedFood: json["has_consumed_food"] == null ? null : json["has_consumed_food"],
    hasMeasuredWeight: json["has_measured_weight"] == null ? null : json["has_measured_weight"],
  );

  Map<String, dynamic> toJson() => {
    "sl": sl == null ? null : sl,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "date": date == null ? null : date,
    "has_consumed_food": hasConsumedFood == null ? null : hasConsumedFood,
    "has_measured_weight": hasMeasuredWeight == null ? null : hasMeasuredWeight,
  };
}
