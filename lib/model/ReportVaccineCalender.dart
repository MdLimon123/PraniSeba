// To parse this JSON data, do
//
//     final reportVaccineCalender = reportVaccineCalenderFromJson(jsonString);

import 'dart:convert';

ReportVaccineCalender reportVaccineCalenderFromJson(String str) => ReportVaccineCalender.fromJson(json.decode(str));

String reportVaccineCalenderToJson(ReportVaccineCalender data) => json.encode(data.toJson());

class ReportVaccineCalender {
  ReportVaccineCalender({
    this.cattleCount,
    this.data,
  });

  int? cattleCount;
  List<Datum>? data;

  factory ReportVaccineCalender.fromJson(Map<String, dynamic> json) => ReportVaccineCalender(
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
    this.cattleDiseaseId,
    this.cattleVaccineId,
    this.date,
    this.remark,
  });

  int? id;
  int? farmId;
  int? cattleId;
  int? cattleDiseaseId;
  int? cattleVaccineId;
  String? date;
  String? remark;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    cattleDiseaseId: json["cattle_disease_id"] == null ? null : json["cattle_disease_id"],
    cattleVaccineId: json["cattle_vaccine_id"] == null ? null : json["cattle_vaccine_id"],
    date: json["date"] == null ? null : json["date"],
    remark: json["remark"] == null ? null : json["remark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "cattle_disease_id": cattleDiseaseId == null ? null : cattleDiseaseId,
    "cattle_vaccine_id": cattleVaccineId == null ? null : cattleVaccineId,
    "date": date == null ? null : date,
    "remark": remark == null ? null : remark,
  };
}
