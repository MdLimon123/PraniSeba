import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationsInfo.dart';
import 'package:prani_sheba/view/cow_registraton/DiseaseInfo.dart';
import 'package:prani_sheba/view/cow_registraton/EatingFood.dart';
import 'package:prani_sheba/view/cow_registraton/MilkManufactureInfo.dart';
import 'package:prani_sheba/view/cow_registraton/VaccineInfo.dart';
import 'package:prani_sheba/view/cow_registraton/WeightMeasurement.dart';

class CowRegistrationHome extends StatelessWidget {
  static const routeName = 'cow_registration_home';

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = const <Choice>[
      const Choice(
          title: 'গাভী/ষাঁড় সম্পর্কিত', icon: "assets/images/cow_reg.png"),
      const Choice(
          title: 'দুধ উৎপাদন সম্পর্কিত',
          icon: "assets/images/milk_production.png"),
      const Choice(title: 'কৃমিনাশক ও টিকা', icon: "assets/images/vacine.png"),
      const Choice(
          title: 'রোগ সম্পর্কিত তথ্য', icon: "assets/images/disease.png"),
      const Choice(title: 'ওজন পরিমাপ', icon: "assets/images/weight.png"),
      const Choice(title: 'খাবার গ্রহণ', icon: "assets/images/eating.png"),
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
        title: Text('পগাভী/ষাঁড় নিবন্ধন'),
        //   title: Text(farmsToList.length.toString() + farmsToList[0].name),
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
              margin:
              EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 10),
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
        Navigator.pushNamed(context, CowRegistrationsInfo.routeName);
        break;

      case 1:
        Navigator.pushNamed(context, MilkManufactureInfo.routeName);
        break;

      case 2:
        Navigator.pushNamed(context, VaccineInfo.routeName);
        break;

      case 3:
        Navigator.pushNamed(context, DiseaseInfo.routeName);
        break;

      case 4:
        Navigator.pushNamed(context, WeightMeasurement.routeName);
        break;

      case 5:
        Navigator.pushNamed(context, EatingFood.routeName);
        break;
    }
  }
}
