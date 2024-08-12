import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportFarms.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportFarmsController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportFarms().obs;
  var dataList = <Datum>[].obs;

  void fetchReportFarms(
  String divisionId, String districtId, String upazilaId,
      {required String farmsId}) async {
    try{
      isLoading(true);
      var farms = await NetworkServices.fetchReportFarms(divisionId,districtId, upazilaId, farmsId: farmsId,);
      if(farms != null){
        productList.value = farms;
        dataList.value = farms.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}