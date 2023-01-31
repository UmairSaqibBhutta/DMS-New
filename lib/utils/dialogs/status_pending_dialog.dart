import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../../configs/constants.dart';
import '../../configs/text_styles.dart';
import '../../helper_widgets/custom_icon_button.dart';

showPendingDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
    return Dialog(
      alignment: Alignment.center,
      shape: circularBorder,
      elevation: 5.0,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Upload Document",style: upStyle,),
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.close)),

                ],
              ),
              Divider(color: lightBlackColor,thickness: 1.5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomIconButton(
                      onTap: (){},
                      icon: Icons.camera,
                      bgColor: whiteColor,
                      borderColor: appColor,
                      text: "Camera",
                      fontSize: 12.0,
                      height: 40.0,
                      iconColor:appColor ,
                    ),
                  ),
                  Expanded(
                    child: CustomIconButton(
                      onTap: (){},
                      text: "Choose File",
                      fontSize: 12.0,
                      iconColor: appColor,
                      bgColor: whiteColor,
                      borderColor: appColor,
                      height: 40.0,
                      icon: Icons.file_copy,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  });

}