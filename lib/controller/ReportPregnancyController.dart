import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/pregnancy_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportPregnancyController extends GetxController {
  var isLoading = true.obs;
  var productList = PregnancyModel().obs;
  var dataList = <Data>[].obs;

  void fetchReport(String farmsId, String cattleGroupId, String cattleId) async {
    try {
      isLoading(true);
      var farms = await NetworkServices.fetchReportPregnancy(
        farmsId,
        cattleGroupId,
        cattleId,
      );
      if (farms != null) {
        productList.value = farms;
        dataList.value = farms.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}
