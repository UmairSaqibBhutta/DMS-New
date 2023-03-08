import 'package:dms_new_project/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class CustomLoader {
  static void showLoader(
      {required BuildContext context, String message = 'Please wait'}) {

    print('loader started ..');

    showDialog(
        context: context,
        barrierColor: Color(0x00ffffff),
        builder: (_) => Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SpinKitChasingDots(
            color: appColor,
            size: 50.0,
          ),
        ));
  }

  static void hideLoader(BuildContext context) {
    print('hiding loader..');
    // Navigator.pop(context);
    Navigator.of(context, rootNavigator: true).pop();
    // Navigator.of(context).pop();
  }
}





class LoaderContentWidget extends StatelessWidget {
  final String message;

  LoaderContentWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('will pop executed -->');
        return false;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(
            radius: 16.0,
          ),
          SizedBox(height: 10.0),
          Text(
            message,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
          )
        ],
      ),
    );
  }
}

