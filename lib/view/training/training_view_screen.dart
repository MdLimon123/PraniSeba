import 'package:flutter/material.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';

class TrainingViewScreen extends StatelessWidget {
  static const routeName = 'training_view_screen';
  final String url;
  TrainingViewScreen({required this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Topic Name'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(),
      ),
/*      body: Padding(
        padding: EdgeInsets.all(10),
        child: PDF().cachedFromUrl(url),
      ),*/
    );
  }
}
