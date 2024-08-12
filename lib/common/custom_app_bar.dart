import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButtonExist;
   final Function? onBackPressed;

  CustomAppBar({required this.title, this.isBackButtonExist = true, this.onBackPressed});

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: isBackButtonExist
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                })
            : SizedBox(),
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        centerTitle: true);
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 50);
}
