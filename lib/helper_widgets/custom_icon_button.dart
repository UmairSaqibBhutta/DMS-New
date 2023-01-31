
import 'package:dms_new_project/configs/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onTap;
  final Color textColor;
  final Color bgColor;
  final String? text;
  final double fontSize;
  final FontWeight fontWeight;
  final double height;
  final double width;
  final double horizontalMargin;
  final double verticalMargin;
  final double circularBorder;
  final Color borderColor;
  final IconData? icon;
  final Color iconColor;
  final bool isIcon;

  CustomIconButton({this.onTap,
    this.textColor = blackColor,
    this.bgColor = appColor,
    this.text = '',
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w700,
    this.height = 45.0,
    this.width = 130.0,
    this.horizontalMargin = 8.0,
    this.verticalMargin = 8.0,
    this.circularBorder = 8.0,
    this.borderColor = Colors
        .transparent, this.icon, this.iconColor = blackColor, this.isIcon = true
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isIcon ? Container(
            height: height,
            width: width,
            margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(circularBorder),
                      side: BorderSide(color: borderColor),

                    )
                ),
                onPressed: onTap, icon: Icon(icon, color: iconColor,),
                label: Text("$text", style: TextStyle(color: textColor,
                  fontWeight: fontWeight,
                  fontSize: fontSize,),)),
          ) :
          IconButton(onPressed: onTap, icon: Icon(icon, color: iconColor,))

        ]
    );
  }
}
