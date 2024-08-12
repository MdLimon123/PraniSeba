import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//app main them
const kBrightnessTheme = Brightness.light;

///start
//FontWeight
const weight400 = FontWeight.w400;
const weight500 = FontWeight.w500;
const weightBold = FontWeight.bold;

//SizedBox Height
const size5 = SizedBox(height: 5);
const size8 = SizedBox(height: 8);
const size10 = SizedBox(height: 10);
const size15 = SizedBox(height: 15);
const size20 = SizedBox(height: 20);
const size25 = SizedBox(height: 25);
const size30 = SizedBox(height: 30);

//SizedBox Width
const width5 = SizedBox(width: 5);
const width10 = SizedBox(width: 10);
const width15 = SizedBox(width: 15);
const width20 = SizedBox(width: 20);

//Axis Alignment
const crossAxisCenter = CrossAxisAlignment.center;
const mainAxisCenter = MainAxisAlignment.center;
const mainAxisStart = MainAxisAlignment.start;
const crossAxisStart = CrossAxisAlignment.start;
const mainAxisSpaceBetween = MainAxisAlignment.spaceBetween;

final TextStyle heading2 = TextStyle(
  color: Color(0xff686795),
  fontSize: 18,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.5,
);

final TextStyle chatSenderName = TextStyle(
  color: Colors.white,
  fontSize: 24,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.5,
);

final TextStyle bodyText1 = TextStyle(color: Color(0xffAEABC9), fontSize: 14, letterSpacing: 1.2, fontWeight: FontWeight.w500);

final TextStyle bodyTextMessage = TextStyle(fontSize: 13, letterSpacing: 1.5, fontWeight: FontWeight.w600);

final TextStyle bodyTextTime = TextStyle(
  color: Color(0xffAEABC9),
  fontSize: 11,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

Widget getCircularImage(double size, String imageURL) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(borderRadius: new BorderRadius.all(new Radius.circular(size / 2))),
    child: ClipOval(child: FadeInImage.assetNetwork(fit: BoxFit.cover, placeholder: 'assets/images/man_placeholder.jpg', image: imageURL)),
  );
}

Future<String> selectDate(BuildContext context, {String date = ''}) async {
  DateTime selectedLastDay = DateTime.now();
  if (date.length > 0) {
    selectedLastDay = DateFormat("yyyy-MM-dd").parse(date);
  } else {
    selectedLastDay = DateTime.now();
  }
  final DateTime? picked =
      await showDatePicker(context: context, initialDate: selectedLastDay, firstDate: DateTime(1901, 1), lastDate: DateTime(2500));
  if (picked != null && picked != selectedLastDay) selectedLastDay = picked;
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(selectedLastDay);
}
