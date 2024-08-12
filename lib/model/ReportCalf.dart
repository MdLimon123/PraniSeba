// To parse this JSON data, do
//
//     final reportCalf = reportCalfFromJson(jsonString);

import 'dart:convert';

ReportCalf reportCalfFromJson(String str) => ReportCalf.fromJson(json.decode(str));

String reportCalfToJson(ReportCalf data) => json.encode(data.toJson());

class ReportCalf {
  ReportCalf({
    this.calfCount,
    this.data,
  });

  int? calfCount;
  List<Datum>? data;

  factory ReportCalf.fromJson(Map<String, dynamic> json) => ReportCalf(
    calfCount: json["calf_count"] == null ? null : json["calf_count"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "calf_count": calfCount == null ? null : calfCount,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.farmId,
    this.cattleId,
    this.tag,
    this.name,
    this.birthDate,
    this.gender,
    this.weight,
  });

  int? id;
  int? farmId;
  int? cattleId;
  String? tag;
  String? name;
  String? birthDate;
  String? gender;
  String? weight;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    tag: json["tag"] == null ? null : json["tag"],
    name: json["name"] == null ? null : json["name"],
    birthDate: json["birth_date"] == null ? null : json["birth_date"],
    gender: json["gender"] == null ? null : json["gender"],
    weight: json["weight"] == null ? null : json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "tag": tag == null ? null : tag,
    "name": name == null ? null : name,
    "birth_date": birthDate == null ? null : birthDate,
    "gender": gender == null ? null : gender,
    "weight": weight == null ? null : weight,
  };
}
