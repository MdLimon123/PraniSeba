import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prani_sheba/Common/Helper.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/controller/AllDataController.dart';
import 'package:prani_sheba/model/AllData.dart';
import 'package:prani_sheba/model/CalfBirthProblem.dart';
import 'package:prani_sheba/model/Cattle.dart';
import 'package:prani_sheba/model/CattleBreed.dart';
import 'package:prani_sheba/model/CattleData.dart';
import 'package:prani_sheba/model/CattleFood.dart';
import 'package:prani_sheba/model/CattleVaccine.dart';
import 'package:prani_sheba/model/DiseaseHistories.dart';
import 'package:prani_sheba/model/EAccount.dart';
import 'package:prani_sheba/model/ExpenseAccountData.dart';
import 'package:prani_sheba/model/Farm.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/Impregnation.dart';
import 'package:prani_sheba/model/ImpregnationData.dart';
import 'package:prani_sheba/model/IncomeAccountData.dart';
import 'package:prani_sheba/model/ManualHit.dart';
import 'package:prani_sheba/model/ManualHitData.dart';
import 'package:prani_sheba/model/PregnancyExam.dart';
import 'package:prani_sheba/model/PregnancyExamData.dart';
import 'package:prani_sheba/model/cattle_breeds.dart';
import 'package:prani_sheba/model/cattle_diseases.dart';
import 'package:prani_sheba/model/cattle_groups.dart';
import 'package:prani_sheba/model/cattle_vaccines.dart';
import 'package:prani_sheba/model/healthInfoChckbox.dart';
import 'package:prani_sheba/model/insurance_companies.dart';
import 'package:prani_sheba/model/insurance_types.dart';
import 'package:prani_sheba/model/seed_companies.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/about/about_screen.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/calf/CalfData.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';
import 'package:prani_sheba/view/income_expense/IncomeExpenseHome.dart';
import 'package:prani_sheba/view/report/ReportHome.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingHome.dart';
import 'package:prani_sheba/view/training/training_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'cow_registraton/CowRegistrationsInfo.dart';
import 'cow_registraton/DiseaseInfo.dart';
import 'cow_registraton/EatingFood.dart';
import 'cow_registraton/MilkManufactureInfo.dart';
import 'cow_registraton/VaccineInfo.dart';
import 'cow_registraton/WeightMeasurement.dart';
import 'dashboard/dashboard_screen.dart';
import 'income_expense/NewIncomeExprense.dart';
import 'income_expense/income_list_screen.dart';
import 'income_expense/list_of_accounts_screen.dart';
import 'report/ReportAbortion.dart';
import 'report/ReportCalfPage.dart';
import 'report/ReportCattleList.dart';
import 'report/ReportDiseasesPage.dart';
import 'report/ReportFarmsPage.dart';
import 'report/ReportFoodConsumWeightPage.dart';
import 'report/ReportImpregnationPage.dart';
import 'report/ReportMilkProduction.dart';
import 'report/ReportMonthlyPayment.dart';
import 'report/ReportPregnant.dart';
import 'report/ReportVaccineCalenderPage.dart';
import 'report/ReportVaccinePage.dart';
import 'seed_filling/ManualHitSend.dart';
import 'seed_filling/PregnancyInfo.dart';
import 'seed_filling/SeedFillingInfo.dart';
import 'seed_filling/TestsPregnancy.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final AllDataController allDataController = Get.put(AllDataController());

  void getData() async {
    farmsToList = [];
    insurance_typesToList = [];
    insurance_companiesToList = [];
    cattle_groupsToList = [];
    cattle_breedsToList = [];
    cattle_diseasesToList = [];
    cattle_vaccinesToList = [];
    seed_companiesToList = [];
    healthInfoToList = [];
    diseaseHistoriesToList = [];
    cattleToList = [];
    manualHitsToList = [];
    impregnationsToList = [];
    pregnancyExamsToList = [];
    calfBirthProblemToList = [];
    cattleFoodToList = [];
    incomeAccountToList = [];
    expenseAccountToList = [];

    FarmsData to;
    InsuranceTypes insurance_ty;
    InsuranceCompanies insurance_com;
    CattleGroups cattle_grp;
    CattleBreeds cattle_br;
    CattleDiseases cattle_disea;
    CattleVaccines cattle_vaccines;
    SeedCompanies seedCompanies;
    HealthInfoCheckbox healthInfoCheckbox;
    DiseaseHistories diseaseHistories;
    CattleData cattleData;
    ManualHitData manualHitData;
    ImpregnationData impregnationData;
    PregnancyExamData pregnancyExamData;
    CalfBirthProblem calfBirthProblem;
    CattleFood cattleFood;
    IncomeAccountData incomeAccountData;
    ExpenseAccountData expenseAccountData;

    prefs = await SharedPreferences.getInstance();
    // var response = await http.get('https://jsonplaceholder.typicode.com/users');
    var response = await http.post(Uri.parse(NetworkServices.baseUrl + 'data'),
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode} headers: $headersToken');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);

      List<CattleVaccine>? vacchinList = AllData.fromJson(body).cattleVaccines;
      List<Farm>? farmsList = AllData.fromJson(body).farms;
      debugPrint("===========> Check All Farms List : $farmsList");

      List<CattleBreed>? insuranceTypeList =
          AllData.fromJson(body).insuranceTypes;
      List<CattleBreed>? insuranceCompList =
          AllData.fromJson(body).insuranceCompanies;
      List<CattleBreed>? cattle_grpList = AllData.fromJson(body).cattleGroups;
      List<CattleBreed>? cattle_brList = AllData.fromJson(body).cattleBreeds;
      List<CattleBreed>? cattle_diseasesList =
          AllData.fromJson(body).cattleDiseases;
      List<CattleBreed>? seed_companiesList =
          AllData.fromJson(body).seedCompanies;

      List<CattleBreed>? diseaseHistoriesList =
          AllData.fromJson(body).diseaseHistories;
      List<CattleBreed>? healthInfoList = AllData.fromJson(body).healthInfo;
      List<Cattle>? cattleList = AllData.fromJson(body).cattle;
      List<ManualHit>? manualHitList = AllData.fromJson(body).manualHits;
      List<Impregnation>? impregnationList =
          AllData.fromJson(body).impregnations;
      List<PregnancyExam>? pregnancyExamList =
          AllData.fromJson(body).pregnancyExams;
      List<CattleBreed>? calfBirthProblemList =
          AllData.fromJson(body).calfBirthProblems;
      List<CattleBreed>? cattleFoodList = AllData.fromJson(body).cattleFoods;
      List<EAccount>? incomeList = AllData.fromJson(body).incomeAccounts;
      List<EAccount>? expenseList = AllData.fromJson(body).expenseAccounts;

      for (int i = 0; i < vacchinList!.length; i++) {
        cattle_vaccines = CattleVaccines();
        cattle_vaccines.id = i;
        cattle_vaccines.disease_id = int.parse(vacchinList[i].diseaseId??"0");
        cattle_vaccines.name = vacchinList[i].name;
        cattle_vaccinesToList!.add(cattle_vaccines);
      }

      for (int i = 0; i < farmsList!.length; i++) {
        to = FarmsData();
        to.id = farmsList[i].id;
        to.name = farmsList[i].name;
        to.divisionId = farmsList[i].divisionId;
        to.districtId = farmsList[i].districtId;
        to.upazilaId = farmsList[i].upazilaId;
        farmsToList!.add(to);
      }

      for (int i = 0; i < insuranceTypeList!.length; i++) {
        insurance_ty = InsuranceTypes();
        insurance_ty.id = insuranceTypeList[i].id;
        insurance_ty.name = insuranceTypeList[i].name;
        insurance_typesToList!.add(insurance_ty);
      }

      for (int i = 0; i < insuranceCompList!.length; i++) {
        insurance_com = InsuranceCompanies();
        insurance_com.id = insuranceCompList[i].id;
        insurance_com.name = insuranceCompList[i].name;
        insurance_companiesToList!.add(insurance_com);
      }

      for (int i = 0; i < cattle_grpList!.length; i++) {
        cattle_grp = CattleGroups();
        cattle_grp.id = cattle_grpList[i].id;
        cattle_grp.name = cattle_grpList[i].name;
        cattle_groupsToList!.add(cattle_grp);
      }

      for (int i = 0; i < cattle_brList!.length; i++) {
        cattle_br = CattleBreeds();
        cattle_br.id = cattle_brList[i].id;
        cattle_br.name = cattle_brList[i].name;
        cattle_breedsToList!.add(cattle_br);
      }
      //
      for (int i = 0; i < cattle_diseasesList!.length; i++) {
        cattle_disea = CattleDiseases();
        cattle_disea.id = cattle_diseasesList[i].id;
        cattle_disea.name = cattle_diseasesList[i].name;
        cattle_diseasesToList!.add(cattle_disea);
      }

      for (int i = 0; i < seed_companiesList!.length; i++) {
        seedCompanies = SeedCompanies();
        seedCompanies.id = seed_companiesList[i].id;
        seedCompanies.name = seed_companiesList[i].name;
        seed_companiesToList!.add(seedCompanies);
      }
      for (int i = 0; i < diseaseHistoriesList!.length; i++) {
        diseaseHistories = DiseaseHistories(
            diseaseHistoriesList[i].id!, diseaseHistoriesList[i].name!);
        diseaseHistoriesToList!.add(diseaseHistories);
      }

      for (int i = 0; i < healthInfoList!.length; i++) {
        healthInfoCheckbox =
            HealthInfoCheckbox(healthInfoList[i].id!, healthInfoList[i].name!);
        healthInfoToList!.add(healthInfoCheckbox);
      }

      for (int i = 0; i < cattleList!.length; i++) {
        cattleData = CattleData();
        cattleData.id = cattleList[i].id;
        cattleData.farmId = cattleList[i].farmId;
        cattleData.tag = cattleList[i].tag;
        cattleData.name = cattleList[i].name;
        cattleData.cattleGroupId = cattleList[i].cattleGroupId;
        cattleData.cattleBreedId = cattleList[i].cattleBreedId;
        cattleData.birthDate = cattleList[i].birthDate;
        cattleData.weight = cattleList[i].weight;
        cattleData.gender = cattleList[i].gender;
        cattleData.healthProblem = cattleList[i].healthProblem;
        cattleData.avgMilkProduction = cattleList[i].avgMilkProduction;
        cattleData.milkProductionStatus = cattleList[i].milkProductionStatus;
        cattleData.calfCount = cattleList[i].calfCount;
        cattleData.lastCalfBirthDate = cattleList[i].lastCalfBirthDate;
        cattleData.geneticPercentage = cattleList[i].geneticPercentage;
        cattleData.insuranceCompanyId = cattleList[i].insuranceCompanyId;
        cattleData.insuranceTypeId = cattleList[i].insuranceTypeId;
        cattleData.insuranceNo = cattleList[i].insuranceNo;
        cattleData.frontImage1 = cattleList[i].frontImage1;
        cattleData.frontImage2 = cattleList[i].frontImage2;
        cattleData.leftImage1 = cattleList[i].leftImage1;
        cattleData.leftImage2 = cattleList[i].leftImage2;
        cattleData.rightImage1 = cattleList[i].rightImage1;
        cattleData.rightImage2 = cattleList[i].rightImage2;
        cattleData.backImage1 = cattleList[i].backImage1;
        cattleData.backImage2 = cattleList[i].backImage2;
        cattleToList!.add(cattleData);
      }
      debugPrint("Response Cattle To List =======> : $cattleToList");

      for (int i = 0; i < manualHitList!.length; i++) {
        manualHitData = ManualHitData();
        manualHitData.id = manualHitList[i].id;
        manualHitData.cattleId = manualHitList[i].cattleId;
        manualHitData.date = manualHitList[i].date;
        manualHitsToList!.add(manualHitData);
      }

      for (int i = 0; i < impregnationList!.length; i++) {
        impregnationData = ImpregnationData();
        impregnationData.id = impregnationList[i].id;
        impregnationData.farmId = impregnationList[i].farmId;
        impregnationData.cattleId = impregnationList[i].cattleId;
        impregnationData.manualHitId = impregnationList[i].manualHitId;
        impregnationData.palDate = impregnationList[i].palDate;
        impregnationData.palType = impregnationList[i].palType;
        impregnationData.palBreedId = impregnationList[i].palBreedId;
        impregnationData.palGroupId = impregnationList[i].palGroupId;
        impregnationData.seedCompanyId = impregnationList[i].seedCompanyId;
        impregnationData.seedPercentage = impregnationList[i].seedPercentage;
        impregnationData.strawNumber = impregnationList[i].strawNumber;
        impregnationData.workerInfo = impregnationList[i].workerInfo;
        impregnationsToList!.add(impregnationData);
      }

      for (int i = 0; i < pregnancyExamList!.length; i++) {
        pregnancyExamData = PregnancyExamData();
        pregnancyExamData.id = pregnancyExamList[i].id;
        pregnancyExamData.farmId = pregnancyExamList[i].farmId;
        pregnancyExamData.cattleId = pregnancyExamList[i].cattleId;
        pregnancyExamData.isPregnant = pregnancyExamList[i].isPregnant;
        pregnancyExamData.expectedDeliveryDate =
            pregnancyExamList[i].expectedDeliveryDate;
        pregnancyExamsToList!.add(pregnancyExamData);
      }

      for (int i = 0; i < calfBirthProblemList!.length; i++) {
        calfBirthProblem = CalfBirthProblem(
            calfBirthProblemList[i].id!, calfBirthProblemList[i].name!);
        calfBirthProblemToList!.add(calfBirthProblem);
      }

      for (int i = 0; i < cattleFoodList!.length; i++) {
        cattleFood = CattleFood();
        cattleFood.id = cattleFoodList[i].id;
        cattleFood.name = cattleFoodList[i].name;
        cattleFoodToList!.add(cattleFood);
      }

      for (int i = 0; i < incomeList!.length; i++) {
        incomeAccountData = IncomeAccountData();
        incomeAccountData.id = incomeList[i].id;
        incomeAccountData.type = incomeList[i].type;
        incomeAccountData.name = incomeList[i].name;
        incomeAccountToList!.add(incomeAccountData);
      }

      for (int i = 0; i < expenseList!.length; i++) {
        expenseAccountData = ExpenseAccountData();
        expenseAccountData.id = expenseList[i].id;
        expenseAccountData.type = expenseList[i].type;
        expenseAccountData.name = expenseList[i].name;
        expenseAccountToList!.add(expenseAccountData);
      }
    }

    // print('${farmsToList.length}');
    // print(insurance_typesToList.length);
    // print(insurance_companiesToList.length);
    // print(cattle_groupsToList.length);
    // print(cattle_breedsToList.length);
    // print(cattle_diseasesToList.length);
    // print(cattle_vaccinesToList.length);
    // print(seed_companiesToList.length);
    // print(healthInfoToList.length);
  }

  int sliderIndex = 0;
  List data = [
    'https://sgp1.digitaloceanspaces.com/cosmosgroup/news/2057149_qurbani%20cow%20online%20shop.jpg',
    'https://gumlet.assettype.com/freepressjournal/2021-07/bd593a5e-f198-4502-9f5e-191bb535048a/Untitled_design___2021_07_12T165258_270.png?format=webp&w=400&dpr=2.6',
    'https://i.ytimg.com/vi/OWKNSsQoKOs/maxresdefault.jpg',
    'https://prod-ttp.imgix.net/63114653-ab1c-4351-a1b3-458362a7fdd4/cow.jpg?auto=compress%2Cformat&fit=min&fm=jpg&q=80&rect=0%2C0%2C4725%2C2700&w=1600&h=914&fit=crop&fm=jpg&q=70&auto=format',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: customDrawer(),
      appBar: AppBar(
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        centerTitle: true,
        title: Text('এলপিইপি হোম'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            /*  Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),*/

            // CarouselSlider(
            //   options: CarouselOptions(
            //       aspectRatio: 2.5,
            //       viewportFraction: 1,
            //       initialPage: 0,
            //       enableInfiniteScroll: true,
            //       reverse: false,
            //       autoPlay: true,
            //       autoPlayInterval: Duration(seconds: 5),
            //       autoPlayAnimationDuration: Duration(milliseconds: 1000),
            //       autoPlayCurve: Curves.easeInCubic,
            //       enlargeCenterPage: true,
            //       scrollDirection: Axis.horizontal,
            //       onPageChanged: (int index, reason) {
            //         setState(() {
            //           sliderIndex = index;
            //         });
            //       }),
            //   items: data
            //       .map(
            //         (item) => Stack(
            //           alignment: Alignment.bottomCenter,
            //           children: [
            //             Container(
            //               padding: const EdgeInsets.symmetric(horizontal: 10),
            //               width: double.infinity,
            //               child: ClipRRect(
            //                 borderRadius: BorderRadius.circular(10),
            //                 child: Image.network(
            //                   item,
            //                   fit: BoxFit.cover,
            //                 ),
            //               ),
            //             ),
            //             ListView.builder(
            //                 shrinkWrap: true,
            //                 scrollDirection: Axis.horizontal,
            //                 itemCount: data.length,
            //                 itemBuilder: (context, int index) {
            //                   return Align(
            //                     alignment: Alignment.bottomCenter,
            //                     child: Container(
            //                       width: sliderIndex == index ? 8 : 6,
            //                       height: sliderIndex == index ? 8 : 6,
            //                       margin: EdgeInsets.symmetric(
            //                           vertical: 10.0, horizontal: 5.0),
            //                       decoration: BoxDecoration(
            //                         shape: BoxShape.circle,
            //                         color: sliderIndex == index
            //                             ? Color(0xFF05854C)
            //                             : Colors.white,
            //                       ),
            //                     ),
            //                   );
            //                 }),
            //           ],
            //         ),
            //       )
            //       .toList(),
            // ),


            Container(
              margin: EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 10),
              child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          openNewPage(index, context);
                        },
                        child: SelectCard(choice: choices[index]),
                      ),
                    );
                  })),
            ),
            //showSQlData(),
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem({required IconData icon, required String text, required Function onTap}) {
    return ListTile(
      title: Container(
        margin: EdgeInsets.only(left: 20),
        child: Row(
          children: <Widget>[
            Icon(icon),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(text),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void openNewPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, CowRegistrationHome.routeName);
        break;

      case 1:
        Navigator.pushNamed(context, SeedFillingHome.routeName);
        break;

      case 2:
        Navigator.pushNamed(context, CalfData.routeName);
        break;

      case 3:
        Navigator.pushNamed(context, ReportHome.routeName);
        break;

      case 4:
        Navigator.pushNamed(context, IncomeExpenseHome.routeName);
        break;

      case 5:
        Navigator.pushNamed(context, TrainingScreen.routeName);
        break;
      case 6:
        Navigator.pushNamed(context, AboutScreen.routeName);
        break;
    }
  }

  SizedBox customDrawer() {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: Container(
          margin: EdgeInsets.only(top: 5),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('এলপিইপি হোম'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('ড্যাশবোর্ড'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, DashBoardScreen.routeName);
                },
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('একটি গাভী/ষাঁড় নিবন্ধন'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CowRegistrationHome.routeName);
                },
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গাভী/ষাঁড় সম্পর্কিত',
                onTap: () {
                  Navigator.pushNamed(context, CowRegistrationsInfo.routeName);
                },
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'দুধ উৎপাদন সম্পর্কিত',
                onTap: () =>
                    Navigator.pushNamed(context, MilkManufactureInfo.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'কৃমিনাশক ও টিকা',
                onTap: () =>
                    Navigator.pushNamed(context, VaccineInfo.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'রোগ সম্পর্কিত তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, DiseaseInfo.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'ওজন পরিমাপ',
                onTap: () =>
                    Navigator.pushNamed(context, WeightMeasurement.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'খাবার গ্রহণ',
                onTap: () => Navigator.pushNamed(context, EatingFood.routeName),
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('বীজ ভরন'),
                      )
                    ], //SeedFilling
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SeedFillingHome.routeName);
                },
              ),
              //বীজ ভরন child item
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'ম্যানুয়ালি হিট প্রবেশ',
                onTap: () =>
                    Navigator.pushNamed(context, ManualHitSend.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'বীজ ভরন সংক্রান্ত তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, SeedFillingInfo.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গর্ভবস্থায় পরীক্ষা',
                onTap: () =>
                    Navigator.pushNamed(context, TestsPregnancy.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গর্ভপাত তথ্য সংযোজন',
                onTap: () =>
                    Navigator.pushNamed(context, PregnancyInfo.routeName),
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('বাছুর সংক্রান্ত তথ্য'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CalfData.routeName);
                },
              ),
              /*   ListTile(
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search_rounded),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('খুঁজুন'),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, SearchHome.routeName);
                    },
                  ),
                  //খুঁজুন child item
                  createDrawerBodyItem(
                    icon: Icons.arrow_right,
                    text: 'ছবি দিয়ে খুঁজুন',
                    onTap: () => Navigator.pushReplacementNamed(context, CowRegistrationHome.routeName),
                  ),
                  createDrawerBodyItem(
                    icon: Icons.arrow_right,
                    text: 'বোলাস দিয়ে খুঁজুন',
                    onTap: () => Navigator.pushReplacementNamed(context, CowRegistrationHome.routeName),
                  ),*/
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('রিপোর্ট'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ReportHome.routeName);
                },
              ),
              //রিপোর্ট child item
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গরু সম্পর্কিত তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, ReportCattleList.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'দুধ উৎপাদন',
                onTap: () => Navigator.pushNamed(
                    context, ReportMilkProduction.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'টিকা',
                onTap: () =>
                    Navigator.pushNamed(context, ReportVaccinePage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'টিকার ক্যালেন্ডার',
                onTap: () => Navigator.pushNamed(
                    context, ReportVaccineCalenderPage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'রোগবালাই',
                onTap: () =>
                    Navigator.pushNamed(context, ReportDiseasesPage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'বীজ ভরন',
                onTap: () => Navigator.pushNamed(
                    context, ReportImpregnationPage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'বাছুর সংক্রান্ত তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, ReportCalfPage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'খামার',
                onTap: () =>
                    Navigator.pushNamed(context, ReportFarmsPage.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গর্ভাবস্থায় তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, ReportPregnant.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'গর্ভপাত তথ্য',
                onTap: () =>
                    Navigator.pushNamed(context, ReportAbortion.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'মাসিক পেমেন্ট',
                onTap: () => Navigator.pushNamed(
                    context, ReportMonthlyPayment.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'খাবার গ্রহণ ও ওজন',
                onTap: () => Navigator.pushNamed(
                    context, ReportFoodConsumWeightPage.routeName),
              ),
              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('আয় ব্যায়'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, IncomeExpenseHome.routeName);
                },
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'নতুন আয় ব্যায়',
                onTap: () =>
                    Navigator.pushNamed(context, NewIncomeExprense.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'হিসাবের তালিকা',
                onTap: () => Navigator.pushNamed(
                    context, ListOfAccountsScreen.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'আয়ের তালিকা',
                onTap: () =>
                    Navigator.pushNamed(context, IncomeListScreen.routeName),
              ),
              createDrawerBodyItem(
                icon: Icons.arrow_right,
                text: 'ব্যায়ের তালিকা',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IncomeListScreen(
                      accountStatus: false,
                    ),
                  ),
                ),
              ),

              ListTile(
                title: Container(
                  child: Row(
                    children: <Widget>[
                      Image.asset("assets/images/logo.png",
                          width: 25, height: 25),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('এলপিইপি সম্পর্কে'),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AboutScreen.routeName);
                },
              ),
              ListTile(
                  title: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.logout),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text('লগ আউট'),
                        )
                      ],
                    ),
                  ),
                  onTap: () async {
                    AwesomeDialog(
                      context: context,
                      // dialogType: DialogType.WARNING,
                      // animType: AnimType.BOTTOMSLIDE,
                      title: 'লগ আউট',
                      desc: 'আপনি কি লগআউট করতে চান?',
                      btnCancelText: 'পরে',
                      btnOkText: 'ওকে',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        prefs!.clear();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Login_page.routeName,
                            (Route<dynamic> route) => false);
                      },
                    ).show();
                  }),
              ListTile(
                title: Text('App version 1.0.0'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
