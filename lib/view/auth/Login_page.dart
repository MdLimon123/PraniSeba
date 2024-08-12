import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/model/LoginResponse.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../HomePage.dart';

class Login_page extends StatefulWidget {
  static const routeName = 'login_page';
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login_page> {
  TextEditingController userNameCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        // you can put Icon as well, it accepts any widget.
        //title: Text ("Your Title"),
        centerTitle: true,
        title: Text('লগইন'),
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
              margin: EdgeInsets.only(top: 35, left: 12, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: userNameCon,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'ব্যবহারকারীর নম্বর',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: passwordCon,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'পাসওয়ার্ড',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 35, left: 12, right: 12),
              child: MaterialButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(0.0),
                shape: StadiumBorder(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    gradient: LinearGradient(
                      colors: [Colors.yellow, Colors.blue],
                    ),
                  ),
                  child: Text(
                    'লগইন করুন',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  padding:
                  EdgeInsets.symmetric(horizontal: 70.0, vertical: 15.0),
                ),
                onPressed: () {
                  //loin user click
                  loginUser();

                  /*  Fluttertoast.showToast(
                        msg:passwordCon.text+userNameCon.text,
                        toastLength: Toast.LENGTH_SHORT,
                        fontSize: 16,
                        textColor: Colors.blue,
                        backgroundColor: Colors.red,
                        gravity: ToastGravity.BOTTOM);*/
                },
              ),
            ),
            /*    Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 15, left: 12, right: 12),
                child: TextButton(
                  child: Text(
                    "পাসওয়ার্ড ভুলে গেছেন‌",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.grey),
                  ),
                  onPressed: () {
                    print('Gradient RaisedButton clicked');
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(top: 0, left: 12, right: 12),
                child: TextButton(
                  child: Text(
                    "অতিথি হিসেবে লগিন‌",
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    print('Gradient RaisedButton clicked');
                  },
                ),
              ),*/
          ],
        ),
      ),
    );
  }

  Future loginUser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Customdialog());

    print('Username: ${userNameCon.text}');
    print('Password: ${passwordCon.text}');
    print('You Hit: ${NetworkServices.baseUrl + 'login'}');

    http.Response response =
        await http.post(Uri.parse(NetworkServices.baseUrl + 'login'), body: {
      'username': userNameCon.text,
      'password': passwordCon.text,
    });

    switch (response.statusCode) {
      case 200:
        final responseJson = json.decode(response.body);
        print(response.body);
        saveCurrentLogin(responseJson);
        break;
      case 401:
        Navigator.pop(context, true);
        Fluttertoast.showToast(
            msg: 'আপনার ইজারনাম অথবা পাসওয়ার্ড ভুল হয়েছে!',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16,
            textColor: Colors.red,
            backgroundColor: Colors.blue,
            gravity: ToastGravity.BOTTOM);
        break;

      default:
        Navigator.pop(context, true);
        Fluttertoast.showToast(
            msg:
                'দয়ে করে ‍আপনার ইন্টারনেট কানেকশন চেক করুন!, আবার চেষ্ঠা করুন।',
            toastLength: Toast.LENGTH_SHORT,
            fontSize: 16,
            textColor: Colors.red,
            backgroundColor: Colors.blue,
            gravity: ToastGravity.BOTTOM);
        break;
    }
  }

  saveCurrentLogin(Map responseJson) async {
    Fluttertoast.showToast(
        // msg: LoginResponse.fromJson(responseJson).token,
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        fontSize: 16,
        textColor: Colors.white,
        backgroundColor: Colors.blue,
        gravity: ToastGravity.BOTTOM);

    prefs = await SharedPreferences.getInstance();
    prefs!.setString(
        'token', LoginResponse.fromJson(responseJson).token.toString());

    setState(() {});

    Navigator.of(context).pushNamedAndRemoveUntil(
        HomePage.routeName, (Route<dynamic> route) => false);
  }
}
