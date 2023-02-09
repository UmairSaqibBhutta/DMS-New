
import 'package:dms_new_project/configs/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Images Paths

const String jpg="assets/icons/jpg_icon.jpg";
const String pdf="assets/icons/pdf_icon.png";
const String png="assets/icons/png_icon.png";
const String ppt="assets/icons/ppt_icon.png";
const String word="assets/icons/word_icon.png";
const String xls="assets/icons/xls_icon.png";
const String placeHolder="assets/icons/image_placeholder.png";

/////////////////////////
IconThemeData iconTheme=IconThemeData(color: blackColor);

 RoundedRectangleBorder circularBorder=RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(15.0)
);
OutlineInputBorder enabledBorder=OutlineInputBorder(
 borderSide: BorderSide(color: blackColor),
 borderRadius: BorderRadius.circular(12.0)
);
OutlineInputBorder focusedBorder=OutlineInputBorder(
 borderSide: BorderSide(color: appColor),
 borderRadius: BorderRadius.circular(12.0)
);
BoxDecoration boxDecoration=BoxDecoration(
 borderRadius: BorderRadius.circular(10.0),
 border: Border.all(color: Colors.black12)
);
Divider divider=Divider(
 thickness: 1.5,
);
Padding padding=Padding(padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),);