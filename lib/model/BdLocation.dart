 // To parse this JSON data, do
//
//     final bdLocation = bdLocationFromJson(jsonString);

import 'dart:convert';

BdLocation bdLocationFromJson(String str) => BdLocation.fromJson(json.decode(str));

String bdLocationToJson(BdLocation data) => json.encode(data.toJson());

class BdLocation {
  BdLocation({
    this.divisions,
    this.districts,
    this.upazilas,
  });

  List<Division>? divisions;
  List<District>? districts;
  List<Upazila>? upazilas;

  factory BdLocation.fromJson(Map<String, dynamic> json) => BdLocation(
    divisions: json["divisions"] == null ? null : List<Division>.from(json["divisions"].map((x) => Division.fromJson(x))),
    districts: json["districts"] == null ? null : List<District>.from(json["districts"].map((x) => District.fromJson(x))),
    upazilas: json["upazilas"] == null ? null : List<Upazila>.from(json["upazilas"].map((x) => Upazila.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "divisions": divisions == null ? null : List<dynamic>.from(divisions!.map((x) => x.toJson())),
    "districts": districts == null ? null : List<dynamic>.from(districts!.map((x) => x.toJson())),
    "upazilas": upazilas == null ? null : List<dynamic>.from(upazilas!.map((x) => x.toJson())),
  };
}

class District {
  District({
    this.id,
    this.divisionId,
    this.bnName,
  });

  int? id;
  int? divisionId;
  String? bnName;

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"] == null ? null : json["id"],
    divisionId: json["division_id"] == null ? null : json["division_id"],
    bnName: json["bn_name"] == null ? null : json["bn_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "division_id": divisionId == null ? null : divisionId,
    "bn_name": bnName == null ? null : bnName,
  };
}

class Division {
  Division({
    this.id,
    this.bnName,
  });

  int? id;
  String? bnName;

  factory Division.fromJson(Map<String, dynamic> json) => Division(
    id: json["id"] == null ? null : json["id"],
    bnName: json["bn_name"] == null ? null : json["bn_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "bn_name": bnName == null ? null : bnName,
  };
}

class Upazila {
  Upazila({
    this.id,
    this.districtId,
    this.bnName,
  });

  int? id;
  int? districtId;
  String? bnName;

  factory Upazila.fromJson(Map<String, dynamic> json) => Upazila(
    id: json["id"] == null ? null : json["id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    bnName: json["bn_name"] == null ? null : json["bn_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "district_id": districtId == null ? null : districtId,
    "bn_name": bnName == null ? null : bnName,
  };
}
