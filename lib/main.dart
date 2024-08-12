import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/Common/Helper.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/model/CalfBirthProblem.dart';
import 'package:prani_sheba/model/CattleData.dart';
import 'package:prani_sheba/model/CattleFood.dart';
import 'package:prani_sheba/model/DiseaseHistories.dart';
import 'package:prani_sheba/model/ExpenseAccountData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/ImpregnationData.dart';
import 'package:prani_sheba/model/IncomeAccountData.dart';
import 'package:prani_sheba/model/ManualHitData.dart';
import 'package:prani_sheba/model/PregnancyExamData.dart';
import 'package:prani_sheba/model/cattle_breeds.dart';
import 'package:prani_sheba/model/cattle_diseases.dart';
import 'package:prani_sheba/model/cattle_groups.dart';
import 'package:prani_sheba/model/cattle_vaccines.dart';
import 'package:prani_sheba/model/healthInfoChckbox.dart';
import 'package:prani_sheba/model/insurance_companies.dart';
import 'package:prani_sheba/model/insurance_types.dart';
import 'package:prani_sheba/model/seed_companies.dart';
import 'package:prani_sheba/routes.dart';
import 'package:prani_sheba/view/SplashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
 List<FarmsData>? farmsToList;
List<InsuranceTypes>? insurance_typesToList;
List<InsuranceCompanies>? insurance_companiesToList;
List<CattleGroups>? cattle_groupsToList;
List<CattleBreeds>? cattle_breedsToList;
List<CattleDiseases>? cattle_diseasesToList;
List<CattleVaccines>? cattle_vaccinesToList;
List<SeedCompanies>? seed_companiesToList;
List<HealthInfoCheckbox>? healthInfoToList;
List<DiseaseHistories>? diseaseHistoriesToList;
List<CattleData>? cattleToList;
List<ManualHitData>? manualHitsToList;
List<ImpregnationData>? impregnationsToList;
List<PregnancyExamData>? pregnancyExamsToList;
List<CalfBirthProblem>? calfBirthProblemToList;
List<CattleFood>? cattleFoodToList;
List<IncomeAccountData>? incomeAccountToList;
List<ExpenseAccountData>? expenseAccountToList;

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:
        Color(Helper.getHexToInt(CommonColor.primaryColor)), // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'প্রাণিবন্ধু(PraniBondhu)-LPEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashPage.routeName,
      routes: routes,
    );
  }
}
