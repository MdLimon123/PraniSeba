import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/report_monthly_payment_model.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ReportMonthlyPaymentController extends GetxController {
  var isLoading = true.obs;
  var productList = ReportMonthlyPaymentModel().obs;
  var dataList = <Data>[].obs;

  void fetchReport(
      String farmsId, String startDate, String endDate) async {
    try{
      isLoading(true);
      var farms = await NetworkServices.fetchReportMonthlyPayment(farmsId,startDate,endDate,);
      if(farms != null){
        productList.value = farms;
        dataList.value = farms.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}