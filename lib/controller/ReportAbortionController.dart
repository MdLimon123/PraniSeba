import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/abortion_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportAbortionController extends GetxController {
  var isLoading = true.obs;
  var productList = AbortionModel().obs;
  var dataList = <Data>[].obs;

  void fetchReport(String farmsId, String cattleGroupId, String cattleId) async {
    try {
      isLoading(true);
      var farms = await NetworkServices.fetchReportAbortion(
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
