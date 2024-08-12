import 'package:flutter/material.dart';
import 'package:prani_sheba/view/HomePage.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/SplashPage.dart';
import 'package:prani_sheba/view/about/about_screen.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/calf/CalfData.dart';
import 'package:prani_sheba/view/cow_registraton/CowImageUpload.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationsInfo.dart';
import 'package:prani_sheba/view/cow_registraton/DiseaseInfo.dart';
import 'package:prani_sheba/view/cow_registraton/EatingFood.dart';
import 'package:prani_sheba/view/cow_registraton/MilkManufactureInfo.dart';
import 'package:prani_sheba/view/cow_registraton/VaccineInfo.dart';
import 'package:prani_sheba/view/cow_registraton/WeightMeasurement.dart';
import 'package:prani_sheba/view/dashboard/dashboard_screen.dart';
import 'package:prani_sheba/view/income_expense/IncomeExpenseHome.dart';
import 'package:prani_sheba/view/income_expense/NewIncomeExprense.dart';
import 'package:prani_sheba/view/income_expense/expense_list_screen.dart';
import 'package:prani_sheba/view/income_expense/income_list_screen.dart';
import 'package:prani_sheba/view/income_expense/list_of_accounts_screen.dart';
import 'package:prani_sheba/view/report/ReportAbortion.dart';
import 'package:prani_sheba/view/report/ReportCalfPage.dart';
import 'package:prani_sheba/view/report/ReportCattleList.dart';
import 'package:prani_sheba/view/report/ReportDiseasesPage.dart';
import 'package:prani_sheba/view/report/ReportFarmsPage.dart';
import 'package:prani_sheba/view/report/ReportFoodConsumWeightPage.dart';
import 'package:prani_sheba/view/report/ReportHome.dart';
import 'package:prani_sheba/view/report/ReportImpregnationPage.dart';
import 'package:prani_sheba/view/report/ReportMilkProduction.dart';
import 'package:prani_sheba/view/report/ReportMonthlyPayment.dart';
import 'package:prani_sheba/view/report/ReportPregnant.dart';
import 'package:prani_sheba/view/report/ReportVaccineCalenderPage.dart';
import 'package:prani_sheba/view/report/ReportVaccinePage.dart';
import 'package:prani_sheba/view/search/SearchHome.dart';
import 'package:prani_sheba/view/seed_filling/ManualHitSend.dart';
import 'package:prani_sheba/view/seed_filling/PregnancyInfo.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingHome.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingInfo.dart';
import 'package:prani_sheba/view/seed_filling/TestsPregnancy.dart';

import 'view/training/training_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  HomePage.routeName: (context) => HomePage(),
  CowRegistrationHome.routeName: (context) => CowRegistrationHome(),
  Login_page.routeName: (context) => Login_page(),
  MyApp2.routeName: (context) => MyApp2(),
  IncomeExpenseHome.routeName: (context) => IncomeExpenseHome(),
  SearchHome.routeName: (context) => SearchHome(),
  SeedFillingHome.routeName: (context) => SeedFillingHome(),
  ReportHome.routeName: (context) => ReportHome(),
  CowRegistrationsInfo.routeName: (context) => CowRegistrationsInfo(),
  MilkManufactureInfo.routeName: (context) => MilkManufactureInfo(),
  DiseaseInfo.routeName: (context) => DiseaseInfo(),
  WeightMeasurement.routeName: (context) => WeightMeasurement(),
  EatingFood.routeName: (context) => EatingFood(),
  VaccineInfo.routeName: (context) => VaccineInfo(),
  ManualHitSend.routeName: (context) => ManualHitSend(),
  TestsPregnancy.routeName: (context) => TestsPregnancy(),
  PregnancyInfo.routeName: (context) => PregnancyInfo(),
  SeedFillingInfo.routeName: (context) => SeedFillingInfo(),
  CalfData.routeName: (context) => CalfData(),
  CowImageUpload.routeName: (context) => CowImageUpload(),
  NewIncomeExprense.routeName: (context) => NewIncomeExprense(),
  ReportCattleList.routeName: (context) => ReportCattleList(),
  ReportMilkProduction.routeName: (context) => ReportMilkProduction(),
  ReportVaccineCalenderPage.routeName: (context) => ReportVaccineCalenderPage(),
  ReportVaccinePage.routeName: (context) => ReportVaccinePage(),
  ReportDiseasesPage.routeName: (context) => ReportDiseasesPage(),
  ReportImpregnationPage.routeName: (context) => ReportImpregnationPage(),
  ReportCalfPage.routeName: (context) => ReportCalfPage(),
  ReportFarmsPage.routeName: (context) => ReportFarmsPage(),
  ReportFoodConsumWeightPage.routeName: (context) =>
      ReportFoodConsumWeightPage(),
  ReportPregnant.routeName: (context) => ReportPregnant(),
  ReportAbortion.routeName: (context) => ReportAbortion(),
  ReportMonthlyPayment.routeName: (context) => ReportMonthlyPayment(),
  ListOfAccountsScreen.routeName: (context) => ListOfAccountsScreen(),
  IncomeListScreen.routeName: (context) => IncomeListScreen(),
  ExpenseListScreen.routeName: (context) => ExpenseListScreen(),
  AboutScreen.routeName: (context) => AboutScreen(),
  DashBoardScreen.routeName: (context) => DashBoardScreen(),
  TrainingScreen.routeName: (context) => TrainingScreen(),
};