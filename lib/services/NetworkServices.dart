import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prani_sheba/model/AllData.dart';
import 'package:prani_sheba/model/BdLocation.dart';
import 'package:prani_sheba/model/CattleReport.dart';
import 'package:prani_sheba/model/Product.dart';
import 'package:prani_sheba/model/ReportCalf.dart';
import 'package:prani_sheba/model/ReportFarms.dart';
import 'package:prani_sheba/model/ReportFoodConsumption.dart';
import 'package:prani_sheba/model/ReportImpregnation.dart';
import 'package:prani_sheba/model/ReportMilkProdResponse.dart';
import 'package:prani_sheba/model/ReportVaccineCalender.dart';
import 'package:prani_sheba/model/abortion_model.dart';
import 'package:prani_sheba/model/pregnancy_model.dart';
import 'package:prani_sheba/model/report_disease_model.dart';
import 'package:prani_sheba/model/report_food_consum_weight_model.dart';
import 'package:prani_sheba/model/report_monthly_payment_model.dart';
import 'package:prani_sheba/model/rpAccount_history_model.dart';
import 'package:prani_sheba/model/rpIncome_list_model.dart';
import 'package:prani_sheba/model/rpdashboard_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

Map<String, String> headersToken = {
  'Accept': 'application/json',
  'Authorization': 'Bearer ${prefs!.getString('token')}',
};

class NetworkServices {
  ///live
  static const String baseUrl = "https://l-pep.org/api/";
  static const String imageUrl = "https://l-pep.com/";
  ///test
  // static const String baseUrl = "https://l-pep.org/api/";    // https://l-pep.com/api/
  // static const String imageUrl = "https://l-pep.com/";
  static var client = http.Client();

  late CattleReport cattleReport;

  Future<AllData> fetchAllData() async {
    prefs = await SharedPreferences.getInstance();
    final response =
        await http.post(Uri.parse(baseUrl + 'data'), headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      print(response.statusCode);
      return AllData.fromJson(body);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<Product?> fetchProducts(var data) async {
    var response =
        await client.get(Uri.parse('https://gorest.co.in/public-api/products'));
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return productFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<BdLocation?> fetchBdLocations() async {
    var response = await client.post(Uri.parse(baseUrl + "locations"),
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return bdLocationFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<CattleReport?> fetchCattleData(
      String farmsId, String cattleGroupId, String gender) async {
    var response = await client.post(Uri.parse(baseUrl + "report/cattle"),
        body: {
          'farm_id': farmsId,
          'cattle_group_id': cattleGroupId,
          'gender': gender
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return cattleReportFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportMilkProdResponse?> fetchMilkProduction(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String startDate,
      String endDate) async {
    var response =
        await client.post(Uri.parse(baseUrl + "report/milk-production"),
            body: {
              'farm_id': farmsId,
              'cattle_group_id': cattleGroupId,
              'cattle_id': cattleId,
              'start_date': startDate,
              'end_date': endDate
            },
            headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportMilkProductionFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportVaccineCalender?> fetchVaccineCalender(
      String farmsId, String cattleDiseaseId) async {
    var response = await client.post(
        Uri.parse(baseUrl + "report/vaccine-calender"),
        body: {'farm_id': farmsId, 'cattle_disease_id': cattleDiseaseId},
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportVaccineCalenderFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportVaccineCalender?> fetchReportVaccine(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String startDate,
      String endDate,
      String diseaseAdsId) async {
    var response = await client.post(Uri.parse(baseUrl + "report/vaccine"),
        body: {
          'farm_id': farmsId,
          'cattle_group_id': cattleGroupId,
          'cattle_id': cattleId,
          'start_date': startDate,
          'end_date': endDate,
          'cattle_disease_ids': diseaseAdsId
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportVaccineCalenderFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<DiseaseModel?> fetchReportDisease(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String startDate,
      String endDate,
      String diseaseAdsId) async {
    var response = await client.post(Uri.parse(baseUrl + "report/disease"),
        body: {
          'farm_id': farmsId,
          'cattle_group_id': cattleGroupId,
          'cattle_id': cattleId,
          'start_date': startDate,
          'end_date': endDate,
          'cattle_disease_ids': diseaseAdsId
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return DiseaseModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportImpregnation?> fetchReportImpregnation(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String startDate,
      String endDate,
      String palBreedId) async {
    var response = await client.post(Uri.parse(baseUrl + "report/impregnation"),
        body: {
          'farm_id': farmsId,
          'cattle_group_id': cattleGroupId,
          'cattle_id': cattleId,
          'start_date': startDate,
          'end_date': endDate,
          'pal_breed_id': palBreedId
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportImpregnationFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportFoodConsumption?> fetchReportFoodConsumption(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String dayCount) async {
    var response =
        await client.post(Uri.parse(baseUrl + "report/food-consumption-weight"),
            body: {
              'farm_id': farmsId,
              'cattle_group_id': cattleGroupId,
              'cattle_id': cattleId,
              'day_count': dayCount
            },
            headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportFoodConsumptionFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportCalf?> fetchReportCalf(
      String farmsId,
      String cattleGroupId,
      String cattleId,
      String startDate,
      String endDate,
      String gender) async {
    var response = await client.post(Uri.parse(baseUrl + "report/calf"),
        body: {
          'farm_id': farmsId,
          'cattle_group_id': cattleGroupId,
          'cattle_id': cattleId,
          'start_date': startDate,
          'end_date': endDate,
          'gender': gender
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportCalfFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportFarms?> fetchReportFarms(
      String divisionId, String districtId, String upazilaId,
      {required String farmsId}) async {
    var response = await client.post(Uri.parse(baseUrl + "report/farm"),
        body: {
          'farm_id': farmsId,
          'division_id': divisionId,
          'district_id': districtId,
          'upazila_id': upazilaId
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return reportFarmsFromJson(jasonString);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<AbortionModel?> fetchReportAbortion(
      String farmID, String cattleGroupID, String cattleID) async {
    var response = await client.post(Uri.parse(baseUrl + "report/abortion"),
        body: {
          'farm_id': farmID,
          'cattle_group_id': cattleGroupID,
          'cattle_id': cattleID
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return AbortionModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<ReportMonthlyPaymentModel?> fetchReportMonthlyPayment(
      String FarmID, String startDate, String endDate) async {
    var response = await client.post(
        Uri.parse(baseUrl + "report/account-entry-all"),
        body: {'farm_id': FarmID, 'start_date': startDate, 'end_date': endDate},
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return ReportMonthlyPaymentModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<FoodConsumWeightModel?> fetchReportFoodConsumWeight(
      String farmID,
      String cattleGroupID,
      String cattleID,
      String dayCount) async {
    var response =
        await client.post(Uri.parse(baseUrl + "report/food-consumption-weight"),
            body: {
              'farm_id': farmID,
              'cattle_group_id': cattleGroupID,
              'cattle_id': cattleID,
              'day_count': dayCount
            },
            headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return FoodConsumWeightModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future<PregnancyModel?> fetchReportPregnancy(
      String farmID, String cattleGroupID, String cattleID) async {
    var response = await client.post(
        Uri.parse(baseUrl + "report/pregnancy-exam"),
        body: {
          'farm_id': farmID,
          'cattle_group_id': cattleGroupID,
          'cattle_id': cattleID
        },
        headers: headersToken);
    print('Url: ${response.request} Response: ${response.statusCode}');
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return PregnancyModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<RpIncomeListModel?> fetchIncomeList({
    required String farmID,
    required String type,
    required String accId,
    required String startDate,
    required String endDate,
  }) async {
    print(farmID);
    print(type);
    print(accId);
    print(startDate);
    print(endDate);
    var response = await client.post(
      Uri.parse(baseUrl + "report/account-entry"),
      body: {
        // 'farm_id': '12',
        // 'type': 'Income',
        // 'account_id': '1',
        // 'start_date': '2021-10-05',
        // 'end_date': '2021-10-05',
        'farm_id': farmID,
        'type': type,
        'account_id': accId,
        'start_date': startDate,
        'end_date': endDate,
      },
      headers: headersToken,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return RpIncomeListModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<RpAccountHistoryModel?> fetchAccountHistory({
    required String farmID,
    required String startDate,
    required String endDate,
  }) async {
    print(farmID);
    print(startDate);
    print(endDate);
    var response = await client.post(
      Uri.parse(baseUrl + "report/account-entry-all"),
      body: {
        'farm_id': farmID,
        'start_date': startDate,
        'end_date': endDate,
      },
      headers: headersToken,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return RpAccountHistoryModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future<RpDashboardModel?> fetchDashBoardData() async {
    var response = await client.post(
      Uri.parse(baseUrl + "summary"),
      headers: headersToken,
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      var jasonString = response.body;
      return RpDashboardModel.fromJson(json.decode(jasonString));
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
