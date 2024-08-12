import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/CattleReport.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportCattleController extends GetxController {
  var isLoading = true.obs;
  var productList = CattleReport().obs;
  var dataList = <Data>[].obs;

  void fetchProducts(String farmsId, String cattleGroupId, String gender) async {
    try {
      isLoading(true);
      var cattle = await NetworkServices.fetchCattleData(farmsId, cattleGroupId, gender);
      if (cattle != null) {
        productList.value = cattle;
        dataList.value = cattle.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}
