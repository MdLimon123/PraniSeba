// To parse this JSON data, do
//
//     final reportImpregnation = reportImpregnationFromJson(jsonString);

import 'dart:convert';

ReportImpregnation reportImpregnationFromJson(String str) => ReportImpregnation.fromJson(json.decode(str));

String reportImpregnationToJson(ReportImpregnation data) => json.encode(data.toJson());

class ReportImpregnation {
  ReportImpregnation({
    this.cattleCount,
    this.data,
  });

  int? cattleCount;
  List<Datum>? data;

  factory ReportImpregnation.fromJson(Map<String, dynamic> json) => ReportImpregnation(
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
    this.id,
    this.farmId,
    this.cattleId,
    this.manualHitId,
    this.palDate,
    this.palType,
    this.palBreedId,
    this.seedCompanyId,
    this.seedPercentage,
    this.strawNumber,
    this.workerInfo,
  });

  int? id;
  int? farmId;
  int? cattleId;
  int? manualHitId;
  String? palDate;
  String? palType;
  int? palBreedId;
  int? seedCompanyId;
  String? seedPercentage;
  String? strawNumber;
  String? workerInfo;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    manualHitId: json["manual_hit_id"] == null ? null : json["manual_hit_id"],
    palDate: json["pal_date"] == null ? null : json["pal_date"],
    palType: json["pal_type"] == null ? null : json["pal_type"],
    palBreedId: json["pal_breed_id"] == null ? null : json["pal_breed_id"],
    seedCompanyId: json["seed_company_id"] == null ? null : json["seed_company_id"],
    seedPercentage: json["seed_percentage"] == null ? null : json["seed_percentage"],
    strawNumber: json["straw_number"] == null ? null : json["straw_number"],
    workerInfo: json["worker_info"] == null ? null : json["worker_info"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "manual_hit_id": manualHitId == null ? null : manualHitId,
    "pal_date": palDate == null ? null : palDate,
    "pal_type": palType == null ? null : palType,
    "pal_breed_id": palBreedId == null ? null : palBreedId,
    "seed_company_id": seedCompanyId == null ? null : seedCompanyId,
    "seed_percentage": seedPercentage == null ? null : seedPercentage,
    "straw_number": strawNumber == null ? null : strawNumber,
    "worker_info": workerInfo == null ? null : workerInfo,
  };


}
