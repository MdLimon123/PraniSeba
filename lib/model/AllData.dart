// To parse this JSON data, do
//
//     final allData = allDataFromJson(jsonString);

// To parse this JSON data, do
//
//     final allData = allDataFromJson(jsonString);

// To parse this JSON data, do
//
//     final allData = allDataFromJson(jsonString);

import 'dart:convert';

import 'package:prani_sheba/model/CattleBreed.dart';
import 'package:prani_sheba/model/CattleVaccine.dart';
import 'package:prani_sheba/model/EAccount.dart';
import 'package:prani_sheba/model/Farm.dart';
import 'package:prani_sheba/model/Impregnation.dart';
import 'package:prani_sheba/model/ManualHit.dart';
import 'package:prani_sheba/model/PregnancyExam.dart';

import 'Cattle.dart';

AllData allDataFromJson(String str) => AllData.fromJson(json.decode(str));

String allDataToJson(AllData data) => json.encode(data.toJson());

class AllData {
  AllData({
    this.farms,
    this.insuranceTypes,
    this.insuranceCompanies,
    this.cattleGroups,
    this.cattleBreeds,
    this.cattleDiseases,
    this.cattleVaccines,
    this.seedCompanies,
    this.diseaseHistories,
    this.healthInfo,
    this.cattle,
    this.manualHits,
    this.impregnations,
    this.pregnancyExams,
    this.calfBirthProblems,
    this.cattleFoods,
    this.incomeAccounts,
    this.expenseAccounts,
  });

  List<Farm>? farms;
  List<CattleBreed>? insuranceTypes;
  List<CattleBreed>? insuranceCompanies;
  List<CattleBreed>? cattleGroups;
  List<CattleBreed>? cattleBreeds;
  List<CattleBreed>? cattleDiseases;
  List<CattleVaccine>? cattleVaccines;
  List<CattleBreed>? seedCompanies;
  List<CattleBreed>? diseaseHistories;
  List<CattleBreed>? healthInfo;
  List<Cattle>? cattle;
  List<ManualHit>? manualHits;
  List<Impregnation>? impregnations;
  List<PregnancyExam>? pregnancyExams;
  List<CattleBreed>? calfBirthProblems;
  List<CattleBreed>? cattleFoods;
  List<EAccount>? incomeAccounts;
  List<EAccount>? expenseAccounts;

  factory AllData.fromJson(Map<String, dynamic> json) => AllData(
    farms: json["farms"] == null ? null : List<Farm>.from(json["farms"].map((x) => Farm.fromJson(x))),
    insuranceTypes: json["insurance_types"] == null ? null : List<CattleBreed>.from(json["insurance_types"].map((x) => CattleBreed.fromJson(x))),
    insuranceCompanies: json["insurance_companies"] == null ? null : List<CattleBreed>.from(json["insurance_companies"].map((x) => CattleBreed.fromJson(x))),
    cattleGroups: json["cattle_groups"] == null ? null : List<CattleBreed>.from(json["cattle_groups"].map((x) => CattleBreed.fromJson(x))),
    cattleBreeds: json["cattle_breeds"] == null ? null : List<CattleBreed>.from(json["cattle_breeds"].map((x) => CattleBreed.fromJson(x))),
    cattleDiseases: json["cattle_diseases"] == null ? null : List<CattleBreed>.from(json["cattle_diseases"].map((x) => CattleBreed.fromJson(x))),
    cattleVaccines: json["cattle_vaccines"] == null ? null : List<CattleVaccine>.from(json["cattle_vaccines"].map((x) => CattleVaccine.fromJson(x))),
    seedCompanies: json["seed_companies"] == null ? null : List<CattleBreed>.from(json["seed_companies"].map((x) => CattleBreed.fromJson(x))),
    diseaseHistories: json["disease_histories"] == null ? null : List<CattleBreed>.from(json["disease_histories"].map((x) => CattleBreed.fromJson(x))),
    healthInfo: json["health_info"] == null ? null : List<CattleBreed>.from(json["health_info"].map((x) => CattleBreed.fromJson(x))),
    cattle: json["cattle"] == null ? null : List<Cattle>.from(json["cattle"].map((x) => Cattle.fromJson(x))),
    manualHits: json["manual_hits"] == null ? null : List<ManualHit>.from(json["manual_hits"].map((x) => ManualHit.fromJson(x))),
    impregnations: json["impregnations"] == null ? null : List<Impregnation>.from(json["impregnations"].map((x) => Impregnation.fromJson(x))),
    pregnancyExams: json["pregnancy_exams"] == null ? null : List<PregnancyExam>.from(json["pregnancy_exams"].map((x) => PregnancyExam.fromJson(x))),
    calfBirthProblems: json["calf_birth_problems"] == null ? null : List<CattleBreed>.from(json["calf_birth_problems"].map((x) => CattleBreed.fromJson(x))),
    cattleFoods: json["cattle_foods"] == null ? null : List<CattleBreed>.from(json["cattle_foods"].map((x) => CattleBreed.fromJson(x))),
    incomeAccounts: json["income_accounts"] == null ? null : List<EAccount>.from(json["income_accounts"].map((x) => EAccount.fromJson(x))),
    expenseAccounts: json["expense_accounts"] == null ? null : List<EAccount>.from(json["expense_accounts"].map((x) => EAccount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "farms": farms == null ? null : List<dynamic>.from(farms!.map((x) => x.toJson())),
    "insurance_types": insuranceTypes == null ? null : List<dynamic>.from(insuranceTypes!.map((x) => x.toJson())),
    "insurance_companies": insuranceCompanies == null ? null : List<dynamic>.from(insuranceCompanies!.map((x) => x.toJson())),
    "cattle_groups": cattleGroups == null ? null : List<dynamic>.from(cattleGroups!.map((x) => x.toJson())),
    "cattle_breeds": cattleBreeds == null ? null : List<dynamic>.from(cattleBreeds!.map((x) => x.toJson())),
    "cattle_diseases": cattleDiseases == null ? null : List<dynamic>.from(cattleDiseases!.map((x) => x.toJson())),
    "cattle_vaccines": cattleVaccines == null ? null : List<dynamic>.from(cattleVaccines!.map((x) => x.toJson())),
    "seed_companies": seedCompanies == null ? null : List<dynamic>.from(seedCompanies!.map((x) => x.toJson())),
    "disease_histories": diseaseHistories == null ? null : List<dynamic>.from(diseaseHistories!.map((x) => x.toJson())),
    "health_info": healthInfo == null ? null : List<dynamic>.from(healthInfo!.map((x) => x.toJson())),
    "cattle": cattle == null ? null : List<dynamic>.from(cattle!.map((x) => x.toJson())),
    "manual_hits": manualHits == null ? null : List<dynamic>.from(manualHits!.map((x) => x.toJson())),
    "impregnations": impregnations == null ? null : List<dynamic>.from(impregnations!.map((x) => x.toJson())),
    "pregnancy_exams": pregnancyExams == null ? null : List<dynamic>.from(pregnancyExams!.map((x) => x.toJson())),
    "calf_birth_problems": calfBirthProblems == null ? null : List<dynamic>.from(calfBirthProblems!.map((x) => x.toJson())),
    "cattle_foods": cattleFoods == null ? null : List<dynamic>.from(cattleFoods!.map((x) => x.toJson())),
    "income_accounts": incomeAccounts == null ? null : List<dynamic>.from(incomeAccounts!.map((x) => x.toJson())),
    "expense_accounts": expenseAccounts == null ? null : List<dynamic>.from(expenseAccounts!.map((x) => x.toJson())),
  };
}