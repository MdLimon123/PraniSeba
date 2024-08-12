import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/controller/dashboard_controller.dart';
import 'package:prani_sheba/view/dashboard/widgets/dashboard_row_widget.dart';

class DashBoardScreen extends StatelessWidget {
  static const routeName = 'dashboard_screen';
  final DashBoardController dashBoardController =
      Get.put(DashBoardController());
  @override
  Widget build(BuildContext context) {
    dashBoardController.fetchDashBoardData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        title: Text('ড্যাশবোর্ড'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (dashBoardController.isLoading.isTrue) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                  ),
                  DashBoardRowWidget(
                    firstTitle: 'মোট ঋণ পয়েন্ট',
                    firstValue: dashBoardController
                        .dashboardList.totalLoanPoints
                        .toString(),
                    secoundTitle: 'মোট ক্রয় পয়েন্ট',
                    secoundValue: dashBoardController
                        .dashboardList.totalPurchasePoints
                        .toString(),
                  ),
                  DashBoardRowWidget(
                    firstTitle: 'মোট বিক্রয় পয়েন্ট',
                    firstValue: dashBoardController
                        .dashboardList.totalSalePoints
                        .toString(),
                    secoundTitle: 'মোট হাতে নগদ',
                    secoundValue:
                        '৳${dashBoardController.dashboardList.totalHandCash.toString()}',
                  ),
                  DashBoardRowWidget(
                    firstTitle: 'মোট প্রদত্ত পয়েন্ট',
                    firstValue: dashBoardController
                        .dashboardList.totalPaidPoints
                        .toString(),
                    secoundTitle: 'মোট উপলব্ধ পয়েন্ট',
                    secoundValue: dashBoardController
                        .dashboardList.totalAvailablePoints
                        .toString(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
