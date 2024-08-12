import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportMilkProdResponse.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportMilkProductinController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportMilkProdResponse().obs;
  var dataList = <Datum>[].obs;

  void fetchMilkProduction(
      String farmsId, String cattleGroupId, String cattleId, String startDate, String endDate) async {
    try{
      isLoading(true);
      var milk = await NetworkServices.fetchMilkProduction(farmsId,cattleGroupId,cattleId,startDate, endDate);
      if(milk != null){
        productList.value = milk;
        dataList.value = milk.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}