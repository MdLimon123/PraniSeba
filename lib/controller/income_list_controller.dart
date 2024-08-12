import 'package:get/get.dart';
import 'package:prani_sheba/model/rpIncome_list_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class IncomeListController extends GetxController {
  RpIncomeListModel incomeList = RpIncomeListModel(data: []);
  var isLoading = false.obs;

  Future<void> fetchIncomeList({
    required String farmID,
    required String type,
    required String accId,
    required String startDate,
    required String endDate,
  }) async {
    try {
      isLoading(true);
      var list = await NetworkServices().fetchIncomeList(
        farmID: farmID,
        type: type,
        accId: accId,
        startDate: startDate,
        endDate: endDate,
      );

      if (list != null) {
        incomeList = list;
      }
    } finally {
      isLoading(false);
    }
  }
}
