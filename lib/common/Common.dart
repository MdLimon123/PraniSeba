import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';


Widget customButtonSearch({required Function onTap, String title = 'খুজুন'}) {
  return Container();
  // return Container(
  //   margin: EdgeInsets.only(top: 15, bottom: 20, right: 12),
  //   alignment: Alignment.centerRight,
  //   child: ElevatedButton.icon(
  //     onPressed: () {
  //       print('Button Clicked.');
  //       onTap();
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
  //     label: Text(
  //       title,
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     icon: Icon(
  //       Icons.search,
  //       color: Colors.white,
  //     ),
  //     textColor: Colors.white,
  //     splashColor: Colors.red,
  //     color: Color(Helper.getHexToInt(CommonColor.primaryColor)),
  //   ),
  // );
}

class Common {
  static void setRightToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)));
  }

  static void setWrongToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.red,
        backgroundColor: Colors.white);
  }

  static String? selectedFarms;
  static String? tagIdCon;
  static String? cattleNameCon;
  static String? selectedCattleGroup;
  static String? selectedCattleBreed;
  static String? dateBirthDay;
  static String? weightCon;
  static String? selectedCattleGender;
  static String? selectedHealthInfo;
  static String? selectedAvrMilkManufacture;
  static String? selectedDhuddhonYsno;
  static String? selectedCattleCount;
  static String? dateLastDay;
  static String? selectedGeneticPercentage;
  static String? selectedInsuranceCompany;
  static String? insuranceNumberCon;
  static String? selectedInsuranceType;
  static String? diseaseHistoryChecked;
  static String? healthInfoChecked;
}
