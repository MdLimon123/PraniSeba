// To parse this JSON data, do
//
//     final reportMilkProduction = reportMilkProductionFromJson(jsonString);

import 'dart:convert';

ReportMilkProdResponse reportMilkProductionFromJson(String str) => ReportMilkProdResponse.fromJson(json.decode(str));

String reportMilkProductionToJson(ReportMilkProdResponse data) => json.encode(data.toJson());

class ReportMilkProdResponse {
  ReportMilkProdResponse({
    this.cattleCount,
    this.mlikCount,
    this.data,
  });

  int? cattleCount;
  int? mlikCount;
  List<Datum>? data;

  factory ReportMilkProdResponse.fromJson(Map<String, dynamic> json) => ReportMilkProdResponse(
    cattleCount: json["cattle_count"] == null ? null : json["cattle_count"],
    mlikCount: json["mlik_count"] == null ? null : json["mlik_count"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cattle_count": cattleCount == null ? null : cattleCount,
    "mlik_count": mlikCount == null ? null : mlikCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.farmId,
    this.cattleId,
    this.date,
    this.time,
    this.value,
  });

  int? id;
  int? farmId;
  int? cattleId;
  String? date;
  String? time;
  int? value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    date: json["date"] == null ? null : json["date"],
    time: json["time"] == null ? null : json["time"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "date": date == null ? null : date,
    "time": time == null ? null : time,
    "value": value == null ? null : value,
  };
}
