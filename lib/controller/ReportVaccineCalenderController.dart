import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportVaccineCalender.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportVaccineCalenderController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportVaccineCalender().obs;
  var dataList = <Datum>[].obs;

  void fetchVaccineCalender(String farmsId, String cattleDiseaseId) async {
    try{
      isLoading(true);
      var vaccine = await NetworkServices.fetchVaccineCalender(farmsId,cattleDiseaseId);
      if(vaccine != null){
        productList.value = vaccine;
        dataList.value = vaccine.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}