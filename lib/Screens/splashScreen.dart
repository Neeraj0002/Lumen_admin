import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lumin_admin/Screens/Dashboard.dart';
import 'package:lumin_admin/Screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loggedIn;
  setLoginFlag() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn');
  }

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      checkLogin().then((value) {
        if (value == true) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            settings: RouteSettings(name: "/dashboard"),
            builder: (context) => DashboardScreen(),
          ));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            settings: RouteSettings(name: "/login"),
            builder: (context) => Login(),
          ));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Image.asset("assets/img/logo.png")],
    ));
  }
}
