// To parse this JSON data, do
//
//     final cattleReport = cattleReportFromJson(jsonString);

import 'dart:convert';

CattleReport cattleReportFromJson(String str) =>
    CattleReport.fromJson(json.decode(str));

String cattleReportToJson(CattleReport data) => json.encode(data.toJson());

class CattleReport {
  CattleReport({
    this.cattleCount,
    this.data,
  });

   int? cattleCount;
  List<Data>? data;

  factory CattleReport.fromJson(Map<String, dynamic> json) => CattleReport(
        cattleCount: json["cattle_count"] == null ? null : json["cattle_count"],
        data: json["data"] == null
            ? null
            : List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cattle_count": cattleCount == null ? null : cattleCount,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.id,
    this.farmId,
    this.tag,
    this.name,
    this.cattleGroupId,
    this.cattleBreedId,
    this.birthDate,
    this.weight,
    this.gender,
    this.healthProblem,
    this.avgMilkProduction,
    this.milkProductionStatus,
    this.calfCount,
    this.lastCalfBirthDate,
    this.geneticPercentage,
    this.insuranceCompanyId,
    this.insuranceTypeId,
    this.insuranceNo,
    this.frontImage1,
    this.frontImage2,
    this.leftImage1,
    this.leftImage2,
    this.rightImage1,
    this.rightImage2,
    this.backImage1,
    this.backImage2,
  });

  int? id;
  int? farmId;
  String? tag;
  String? name;
  int? cattleGroupId;
  int? cattleBreedId;
  String? birthDate;
  String? weight;
  String? gender;
  String? healthProblem;
  String? avgMilkProduction;
  String? milkProductionStatus;
  String? calfCount;
  String? lastCalfBirthDate;
  String? geneticPercentage;
  int? insuranceCompanyId;
  int? insuranceTypeId;
  String? insuranceNo;
  String? frontImage1;
  String? frontImage2;
  String? leftImage1;
  String? leftImage2;
  String? rightImage1;
  String? rightImage2;
  String? backImage1;
  String? backImage2;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        farmId: json["farm_id"] == null ? null : json["farm_id"],
        tag: json["tag"] == null ? null : json["tag"],
        name: json["name"] == null ? null : json["name"],
        cattleGroupId:
            json["cattle_group_id"] == null ? null : json["cattle_group_id"],
        cattleBreedId:
            json["cattle_breed_id"] == null ? null : json["cattle_breed_id"],
        birthDate: json["birth_date"] == null
            ? null
            : json["birth_date"],
        weight: json["weight"] == null ? null : json["weight"],
        gender: json["gender"] == null ? null : json["gender"],
        healthProblem:
            json["health_problem"] == null ? null : json["health_problem"],
        avgMilkProduction: json["avg_milk_production"] == null
            ? null
            : json["avg_milk_production"],
        milkProductionStatus: json["milk_production_status"] == null
            ? null
            : json["milk_production_status"],
        calfCount: json["calf_count"] == null ? null : json["calf_count"],
        lastCalfBirthDate: json["last_calf_birth_date"] == null
            ? null
            : json["last_calf_birth_date"],
        geneticPercentage: json["genetic_percentage"] == null
            ? null
            : json["genetic_percentage"],
        insuranceCompanyId: json["insurance_company_id"] == null
            ? null
            : json["insurance_company_id"],
        insuranceTypeId: json["insurance_type_id"] == null
            ? null
            : json["insurance_type_id"],
        insuranceNo: json["insurance_no"] == null ? null : json["insurance_no"],
        frontImage1:
            json["front_image_1"] == null ? null : json["front_image_1"],
        frontImage2:
            json["front_image_2"] == null ? null : json["front_image_2"],
        leftImage1: json["left_image_1"] == null ? null : json["left_image_1"],
        leftImage2: json["left_image_2"] == null ? null : json["left_image_2"],
        rightImage1:
            json["right_image_1"] == null ? null : json["right_image_1"],
        rightImage2:
            json["right_image_2"] == null ? null : json["right_image_2"],
        backImage1: json["back_image_1"] == null ? null : json["back_image_1"],
        backImage2: json["back_image_2"] == null ? null : json["back_image_2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "farm_id": farmId == null ? null : farmId,
        "tag": tag == null ? null : tag,
        "name": name == null ? null : name,
        "cattle_group_id": cattleGroupId == null ? null : cattleGroupId,
        "cattle_breed_id": cattleBreedId == null ? null : cattleBreedId,
        "birth_date": birthDate == null
            ? null
            : "${birthDate.toString().padLeft(4, '0')}-${birthDate.toString().padLeft(2, '0')}-${birthDate.toString().padLeft(2, '0')}",
        "weight": weight == null ? null : weight,
        "gender": gender == null ? null : gender,
        "health_problem": healthProblem == null ? null : healthProblem,
        "avg_milk_production":
            avgMilkProduction == null ? null : avgMilkProduction,
        "milk_production_status":
            milkProductionStatus == null ? null : milkProductionStatus,
        "calf_count": calfCount == null ? null : calfCount,
        "last_calf_birth_date": lastCalfBirthDate == null
            ? null
            : "${lastCalfBirthDate.toString().padLeft(4, '0')}-${lastCalfBirthDate.toString().padLeft(2, '0')}-${lastCalfBirthDate.toString().padLeft(2, '0')}",
        "genetic_percentage":
            geneticPercentage == null ? null : geneticPercentage,
        "insurance_company_id":
            insuranceCompanyId == null ? null : insuranceCompanyId,
        "insurance_type_id": insuranceTypeId == null ? null : insuranceTypeId,
        "insurance_no": insuranceNo == null ? null : insuranceNo,
        "front_image_1": frontImage1 == null ? null : frontImage1,
        "front_image_2": frontImage2 == null ? null : frontImage2,
        "left_image_1": leftImage1 == null ? null : leftImage1,
        "left_image_2": leftImage2 == null ? null : leftImage2,
        "right_image_1": rightImage1 == null ? null : rightImage1,
        "right_image_2": rightImage2 == null ? null : rightImage2,
        "back_image_1": backImage1 == null ? null : backImage1,
        "back_image_2": backImage2 == null ? null : backImage2,
      };
}
