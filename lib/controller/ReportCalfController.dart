import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportCalf.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportCalfController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportCalf().obs;
  var dataList = <Datum>[].obs;

  void fetchReportCalf(
      String farmsId, String cattleGroupId, String cattleId, String startDate, String endDate,String gender) async {
    try{
      isLoading(true);
      var calf = await NetworkServices.fetchReportCalf(farmsId,cattleGroupId,cattleId,startDate, endDate, gender);
      if(calf != null){
        productList.value = calf;
        dataList.value = calf.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}