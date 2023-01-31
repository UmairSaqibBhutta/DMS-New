import 'dart:async';

import 'package:dms_new_project/configs/colors.dart';
import 'package:flutter/material.dart';

import '../../Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }
  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        backgroundColor: whiteColor,
        body: Center(child: Image.asset("assets/images/dms_app_logo.png")),

      );
  }
}
