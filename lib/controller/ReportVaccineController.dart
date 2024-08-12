import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportVaccineCalender.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportVaccineController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportVaccineCalender().obs;
  var dataList = <Datum>[].obs;

  void fetchReportVaccine(String farmsId, String cattleGroupId, String cattleId, String startDate, String endDate, String diseaseAdsId) async {
    try{
      isLoading(true);
      var vaccine = await NetworkServices.fetchReportVaccine(farmsId,cattleGroupId, cattleId, startDate,endDate, diseaseAdsId);
      if(vaccine != null){
        productList.value = vaccine;
        dataList.value = vaccine.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}