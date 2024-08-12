import 'package:get/get.dart';
import 'package:prani_sheba/model/AllData.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class AllDataController extends GetxController {
  var allPostList = AllData().obs;

  Future<void> fetchAllData() async {
    try {
      var post = await NetworkServices().fetchAllData();

      if (post != null) {
        allPostList.value = post;
      }
    } finally {}
  }

}
