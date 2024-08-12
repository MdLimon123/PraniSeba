import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/ReportImpregnation.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportImpregnationController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportImpregnation().obs;
  var dataList = <Datum>[].obs;

  void fetchReportImpregnation(
      String farmsId, String cattleGroupId, String cattleId, String startDate, String endDate,String palBreedId) async {
    try{
      isLoading(true);
      var impregnation = await NetworkServices.fetchReportImpregnation(farmsId,cattleGroupId,cattleId,startDate, endDate,palBreedId);
      if(impregnation != null){
        productList.value = impregnation;
        dataList.value = impregnation.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}