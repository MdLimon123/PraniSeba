import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/report_food_consum_weight_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportFoodConsumWeightController extends GetxController {
  var isLoading = true.obs;
  var productList = FoodConsumWeightModel().obs;
  var dataList = <Data>[].obs;

  void fetchReport(String farmsId, String cattleGroupId, String cattleId, String dayCount) async {
    try {
      isLoading(true);
      var farms = await NetworkServices.fetchReportFoodConsumWeight(farmsId, cattleGroupId, cattleId, dayCount);
      if (farms != null) {
        productList.value = farms;
        dataList.value = farms.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}
