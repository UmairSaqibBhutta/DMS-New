

import 'package:flutter/cupertino.dart';

import '../configs/colors.dart';

class CustomDropDownDecorationWidget extends StatelessWidget {
  final bool selectedColor;
  final Widget? child;
   CustomDropDownDecorationWidget({this.selectedColor=false, this.child});

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: EdgeInsets.symmetric(vertical: 0.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0),
      height: 45.0,
      decoration: BoxDecoration(
          border: Border.all(color: selectedColor==false?blackColor:appColor,width: 1.2),
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: child,
    );
  }
}
