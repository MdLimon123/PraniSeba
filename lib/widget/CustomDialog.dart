import 'package:flutter/material.dart';

import '../common/CommonColor.dart';
import '../common/Helper.dart';

class Customdialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  color: Colors.white,

                  /* child: Image.asset(
                    'assets/loader.gif',
                    height: 80,
                    width: 80,
                  ),*/
                  child: CircularProgressIndicator(
                    backgroundColor:
                        Color(Helper.getHexToInt(CommonColor.primaryColor)),
                  ),
                  shape: CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                ),
              ),
            ),
          ],
        ));
  }
}
