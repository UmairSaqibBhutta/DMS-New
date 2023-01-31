import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:flutter/material.dart';

import '../configs/constants.dart';

class CustomTextField extends StatelessWidget {
  final String? headerText;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool obscureText;
  final int? maxCharLength;
  final double height;
  final double width;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function()? suffixOnTap;
  final Function(String)? onSubmit;

  CustomTextField(
      {this.headerText,
      this.hintText = '',
      this.controller,
      this.focusNode,
      this.inputType,
      this.inputAction,
      this.obscureText = false,
      this.maxCharLength,
      this.height = 45.0,
      this.width = double.infinity,
      this.suffixIcon,
      this.prefixIcon,
      this.suffixOnTap, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headerText == null
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: headerText == null ? 0.0 : 8.0),
                  child: Text(
                    headerText ?? "",
                    style: headerStyle,
                  ),
                ),
          Container(
            height: height,
            width: width,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: inputType,
              textInputAction: inputAction,
              obscureText: obscureText,
              onSubmitted: onSubmit,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                hintText: hintText,
                enabledBorder: enabledBorder,
                focusedBorder: focusedBorder,
                suffixIcon: suffixIcon == null ? null : IconButton(
                  icon: Icon(suffixIcon,color: appColor,),
                  onPressed: suffixOnTap,
                ),
                prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
              ),
            ),
          )
        ],
      ),
    );
  }
}
