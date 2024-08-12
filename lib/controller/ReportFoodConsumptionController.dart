import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportFoodConsumption.dart';

import 'package:prani_sheba/services/NetworkServices.dart';


class ReportFoodConsumptionController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportFoodConsumption().obs;
  var dataList = <Datum>[].obs;

  void fetchReportFoodConsumption(
      String farmsId, String cattleGroupId, String cattleId, String dayCount) async {
    try{
      isLoading(true);
      var foodConsum = await NetworkServices.fetchReportFoodConsumption(farmsId,cattleGroupId,cattleId,dayCount);
      if(foodConsum != null){
        productList.value = foodConsum;
        dataList.value = foodConsum.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}