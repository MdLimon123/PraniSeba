import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';

class SearchHome extends StatelessWidget{
  static const routeName = 'Search_home';

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = const <Choice>[
      const Choice(
          title: 'ছবি দিয়ে খুঁজুন', icon: "assets/images/cow_icon.png"),
      const Choice(
          title: 'বোলাস দিয়ে খুঁজুন', icon: "assets/images/cow_icon.png"),
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
          title: Text('খুঁজুন'),
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
                margin: EdgeInsets.only(top: 85, left: 12, right: 12, bottom: 10),
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
                            Navigator.pushNamed(
                                context, CowRegistrationHome.routeName);
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
}