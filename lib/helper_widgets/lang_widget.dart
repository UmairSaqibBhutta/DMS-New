


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';
import '../configs/text_styles.dart';

class LanguageWidget extends StatelessWidget {
  final String langText;
  LanguageWidget({required this.langText}) ;

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.0,vertical: 6.0),
          height: 25.0,
          width: 25.0,
          decoration: BoxDecoration(

              shape: BoxShape.rectangle,
              border: Border.all(
                color: black26,
              ),
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Icon(Icons.check),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("${langText}",style: langStyle,),
        ),

      ],
    );
  }
}
