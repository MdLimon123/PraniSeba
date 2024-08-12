import 'package:flutter/material.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/view/training/training_view_screen.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = 'training_screen';
  List data = [
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
    'http://www.africau.edu/images/default/sample.pdf',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'প্রশিক্ষণ'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TrainingViewScreen(
                        url: data[index],
                      );
                    },
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 1.0,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text('Topic name'),
                            ),
                            Image.asset(
                              "assets/images/pdf.png",
                              width: 40,
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
