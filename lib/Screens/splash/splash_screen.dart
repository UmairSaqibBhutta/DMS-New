import 'dart:async';

import 'package:dms_new_project/Screens/app_screens/dashboard_module/home_dashboard_screen.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/helper_services/navigation_services.dart';
import 'package:dms_new_project/utils/local_storage_service/save_user_service.dart';
import 'package:flutter/material.dart';

import '../../Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _getUser()async{
    var user=await getUser();
    user!=null?
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeDashBoardScreen())))
    :Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen())));
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }
  @override
  Widget build(BuildContext context) {
      return  Scaffold(
        backgroundColor: whiteColor,
        body: Center(child: Image.asset("assets/images/dms_app_logo.png")),

      );
  }

}
