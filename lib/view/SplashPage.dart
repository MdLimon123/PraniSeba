import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prani_sheba/view/HomePage.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splash_page';

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animationController.forward();

    Timer(Duration(seconds: 2), () => navigationPage());

    super.initState();
  }

  Future<void> navigationPage() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.containsKey('token')) {
      //Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
      Navigator.of(context).pushNamedAndRemoveUntil(
          HomePage.routeName, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Login_page.routeName, (Route<dynamic> route) => false);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
