import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/report/ReportAbortion.dart';
import 'package:prani_sheba/view/report/ReportCalfPage.dart';
import 'package:prani_sheba/view/report/ReportCattleList.dart';
import 'package:prani_sheba/view/report/ReportDiseasesPage.dart';
import 'package:prani_sheba/view/report/ReportFarmsPage.dart';
import 'package:prani_sheba/view/report/ReportFoodConsumWeightPage.dart';
import 'package:prani_sheba/view/report/ReportImpregnationPage.dart';
import 'package:prani_sheba/view/report/ReportMilkProduction.dart';
import 'package:prani_sheba/view/report/ReportMonthlyPayment.dart';
import 'package:prani_sheba/view/report/ReportPregnant.dart';
import 'package:prani_sheba/view/report/ReportVaccineCalenderPage.dart';
import 'package:prani_sheba/view/report/ReportVaccinePage.dart';

class ReportHome extends StatelessWidget {
  static const routeName = 'report_home';

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = const <Choice>[
      const Choice(
          title: 'গরু সম্পর্কিত তথ্য', icon: "assets/images/cow_reg.png"),
      const Choice(
          title: 'দুধ উৎপাদন', icon: "assets/images/milk_production.png"),
      const Choice(title: 'টিকা', icon: "assets/images/vacine.png"),
      const Choice(
          title: 'টিকার ক্যালেন্ডার', icon: "assets/images/cow_icon.png"),
      const Choice(title: 'রোগবালাই', icon: "assets/images/disease.png"),
      const Choice(title: 'বীজ ভরন', icon: "assets/images/seeds.png"),
      const Choice(
          title: 'বাছুর সংক্রান্ত তথ্য', icon: "assets/images/cow_icon.png"),
      const Choice(title: 'খামার', icon: "assets/images/farms.png"),
      const Choice(
          title: 'গর্ভাবস্থায় তথ্য', icon: "assets/images/pregnancy.png"),
      const Choice(
          title: 'গর্ভপাত তথ্য', icon: "assets/images/pregnancy_info.png"),
      const Choice(title: 'মাসিক পেমেন্ট', icon: "assets/images/income_ex.png"),
      const Choice(
          title: 'খাবার গ্রহণ ও ওজন', icon: "assets/images/weight.png"),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        // you can put Icon as well, it accepts any widget.
        //title: Text ("Your Title"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text('রিপোর্ট'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 10),
              child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          openNewPage(index, context);
                        },
                        child: SelectCard(choice: choices[index]),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }

  void openNewPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, ReportCattleList.routeName);
        break;
      case 1:
        Navigator.pushNamed(context, ReportMilkProduction.routeName);
        break;
      case 2:
        Navigator.pushNamed(context, ReportVaccinePage.routeName);
        break;
      case 3:
        Navigator.pushNamed(context, ReportVaccineCalenderPage.routeName);
        break;

      case 4:
        Navigator.pushNamed(context, ReportDiseasesPage.routeName);
        break;

      case 5:
        Navigator.pushNamed(context, ReportImpregnationPage.routeName);
        break;

      case 6:
        Navigator.pushNamed(context, ReportCalfPage.routeName);
        break;

      case 7:
        Navigator.pushNamed(context, ReportFarmsPage.routeName);
        break;

      case 8:
        Navigator.pushNamed(context, ReportPregnant.routeName);
        break;

      case 9:
        Navigator.pushNamed(context, ReportAbortion.routeName);
        break;
      case 10:
        Navigator.pushNamed(context, ReportMonthlyPayment.routeName);
        break;

      case 11:
        Navigator.pushNamed(context, ReportFoodConsumWeightPage.routeName);
        break;
    }
  }
}
