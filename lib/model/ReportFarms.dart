// To parse this JSON data, do
//
//     final reportFarms = reportFarmsFromJson(jsonString);

import 'dart:convert';

ReportFarms reportFarmsFromJson(String str) => ReportFarms.fromJson(json.decode(str));

String reportFarmsToJson(ReportFarms data) => json.encode(data.toJson());

class ReportFarms {
  ReportFarms({
    this.totalCattleCount,
    this.totalCalvesCount,
    this.data,
  });

  int? totalCattleCount;
  int? totalCalvesCount;
  List<Datum>? data;

  factory ReportFarms.fromJson(Map<String, dynamic> json) => ReportFarms(
    totalCattleCount: json["total_cattle_count"] == null ? null : json["total_cattle_count"],
    totalCalvesCount: json["total_calves_count"] == null ? null : json["total_calves_count"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_cattle_count": totalCattleCount == null ? null : totalCattleCount,
    "total_calves_count": totalCalvesCount == null ? null : totalCalvesCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.divisionId,
    this.districtId,
    this.upazilaId,
    this.cattleCount,
    this.calvesCount,
  });

  int? id;
  String? name;
  int? divisionId;
  int? districtId;
  int? upazilaId;
  int? cattleCount;
  int? calvesCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    divisionId: json["division_id"] == null ? null : json["division_id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    upazilaId: json["upazila_id"] == null ? null : json["upazila_id"],
    cattleCount: json["cattle_count"] == null ? null : json["cattle_count"],
    calvesCount: json["calves_count"] == null ? null : json["calves_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "division_id": divisionId == null ? null : divisionId,
    "district_id": districtId == null ? null : districtId,
    "upazila_id": upazilaId == null ? null : upazilaId,
    "cattle_count": cattleCount == null ? null : cattleCount,
    "calves_count": calvesCount == null ? null : calvesCount,
  };
}
