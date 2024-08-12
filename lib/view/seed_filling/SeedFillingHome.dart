import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/seed_filling/ManualHitSend.dart';
import 'package:prani_sheba/view/seed_filling/PregnancyInfo.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingInfo.dart';
import 'package:prani_sheba/view/seed_filling/TestsPregnancy.dart';

class SeedFillingHome extends StatelessWidget {
  static const routeName = 'seed_filling_home';

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = const <Choice>[
      const Choice(
          title: 'ম্যানুয়ালি হিট প্রবেশ', icon: "assets/images/m_hit.png"),
      const Choice(
          title: 'বীজ ভরন সংক্রান্ত তথ্য', icon: "assets/images/seeds.png"),
      const Choice(
          title: 'গর্ভবস্থায় পরীক্ষা', icon: "assets/images/pregnancy.png"),
      const Choice(
          title: 'গর্ভপাত তথ্য সংযোজন',
          icon: "assets/images/pregnancy_info.png"),
    ];

    return MaterialApp(
      home: Scaffold(
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
          title: Text('বীজ ভরন'),
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
                    EdgeInsets.only(top: 55, left: 12, right: 12, bottom: 10),
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
      ),
    );
  }

  void openNewPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, ManualHitSend.routeName);
        break;

      case 1:
        Navigator.pushNamed(context, SeedFillingInfo.routeName);
        break;

      case 2:
        Navigator.pushNamed(context, TestsPregnancy.routeName);
        break;

      case 3:
        Navigator.pushNamed(context, PregnancyInfo.routeName);
        break;
    }
  }
}
