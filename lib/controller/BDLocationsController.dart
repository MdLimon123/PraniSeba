import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/BdLocation.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class BDLocationsController extends GetxController {
  var isLoading = true.obs;
  var productList = BdLocation().obs;
  var divisionList = <Division>[].obs;
  var districtList = <District>[].obs;
  var upaZilaList = <Upazila>[].obs;
  @override
  void onInit() {
    fetchBdLocations();
    super.onInit();
  }
  void fetchBdLocations() async {
    try{
      isLoading(true);
      var products = await NetworkServices.fetchBdLocations();
      if(products != null){
        productList.value = products;
        divisionList.value = products.divisions!;
        districtList.value = products.districts!;
        upaZilaList.value = products.upazilas!;
      }
    } finally {
      isLoading(false);
    }
  }
}