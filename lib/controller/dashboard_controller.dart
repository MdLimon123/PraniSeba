import 'package:get/get.dart';
import 'package:prani_sheba/model/rpdashboard_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class DashBoardController extends GetxController {
  late RpDashboardModel dashboardList;
  var isLoading = false.obs;

  Future<void> fetchDashBoardData() async {
    try {
      isLoading(true);
      var list = await NetworkServices().fetchDashBoardData();
      if (list != null) {
        dashboardList = list;
      }
    } finally {
      isLoading(false);
    }
  }
}
