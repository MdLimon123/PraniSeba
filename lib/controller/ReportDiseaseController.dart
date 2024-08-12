import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/report_disease_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportDiseaseController extends GetxController {
  var isLoading = true.obs;
  var productList = DiseaseModel().obs;
  var dataList = <Datum>[].obs;

  void fetchReportDisease(String farmsId, String cattleGroupId, String cattleId, String startDate, String endDate, String diseaseAdsId) async {
    try{
      isLoading(true);
      var vaccine = await NetworkServices.fetchReportDisease(farmsId,cattleGroupId, cattleId, startDate,endDate, diseaseAdsId);
      if(vaccine != null){
        productList.value = vaccine;
        dataList.value = vaccine.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}