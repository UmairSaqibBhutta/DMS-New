import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/colors.dart';
import '../../../configs/constants.dart';
import '../../../configs/text_styles.dart';

class FolderCardView extends StatelessWidget {
  String foldName;
  final Function()?onTap;
  final IconData icon;
  FolderCardView({required this.foldName, this.onTap,  this.icon=Icons.folder}) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.0,vertical: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        width: MediaQuery.of(context).size.width/2.3,
        height: MediaQuery.of(context).size.height*0.18,
        child: Card(

          shape: circularBorder,
          elevation: 3.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon,color: appColor,size: 75.0,),
              Text("${foldName}",style: dashStyle,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ),
    );
  }
}