import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';

class MyApp2 extends StatelessWidget {
  static const routeName = 'MyApp2';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Flutter GridView Demo"),
            ),
            body: Container(
              margin: EdgeInsets.all(10),
              child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: SelectCard(choice: choices[index]),
                    );
                  })),
            )));
  }
}

class Choice {
  const Choice({required this.title, required this.icon});
  final String title;
  final String icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'গাভী/ষাঁড় নিবন্ধন', icon: "assets/images/cow_reg.png"),
  const Choice(title: 'বীজ ভরন', icon: "assets/images/seeds.png"),
  const Choice(
      title: 'বাছুর সংক্রান্ত তথ্য', icon: "assets/images/cow_icon.png"),
  const Choice(title: 'রিপোর্ট', icon: "assets/images/report.png"),
  const Choice(title: 'আয় ব্যায়', icon: "assets/images/income_ex.png"),
  const Choice(title: 'প্রশিক্ষণ', icon: "assets/images/training.png"),
  const Choice(title: 'এলপিইপি সম্পর্কে', icon: "assets/images/logo.png"),
];

class SelectCard extends StatelessWidget {
  const SelectCard({ Key? key, required this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(Helper.getHexToInt("#FFFFFF")),
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Image.asset(
                  choice.icon,
                  width: 55,
                  height: 95,
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(choice.title,
                      style: TextStyle(
                          color:
                              Color(Helper.getHexToInt(CommonColor.HomeBlack)),
                          fontSize: 16)),
                ),
              ]),
        ));
  }
}
