import 'package:get/state_manager.dart';
import 'package:prani_sheba/model/Product.dart';
import 'package:prani_sheba/services/NetworkServices.dart';


class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = Product().obs;
  var dataList = <Datum>[].obs;
  @override
  void onInit() {
    fetchProducts(0);
    super.onInit();
  }
  void fetchProducts(int data) async {
    try{
      isLoading(true);
      var products = await NetworkServices.fetchProducts(data);
      if(products != null){
        productList.value = products;
        dataList.value = products.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}