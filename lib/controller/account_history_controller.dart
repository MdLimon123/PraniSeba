import 'package:get/get.dart';
import 'package:prani_sheba/model/rpAccount_history_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class AccountHistoryController extends GetxController {
  RpAccountHistoryModel accountHistory = RpAccountHistoryModel(data: []);
  var isLoading = false.obs;

  Future<void> fetchAccountHistory({
    required String farmID,
    required String startDate,
    required String endDate,
  }) async {
    try {
      isLoading(true);
      var list = await NetworkServices().fetchAccountHistory(
        farmID: farmID,
        startDate: startDate,
        endDate: endDate,
      );
      if (list != null) {
        accountHistory = list;
      }
    } finally {
      isLoading(false);
    }
  }
}
