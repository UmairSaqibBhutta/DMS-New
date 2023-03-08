
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/utils/local_storage_service/language_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/constants.dart';
import '../../configs/text_styles.dart';
import '../../helper_widgets/lang_widget.dart';
import '../../main.dart';


class LanguageChangeDialogScreen extends StatefulWidget {
  const LanguageChangeDialogScreen({Key? key}) : super(key: key);

  @override
  State<LanguageChangeDialogScreen> createState() => _LanguageChangeDialogScreenState();
}

class _LanguageChangeDialogScreenState extends State<LanguageChangeDialogScreen> {
  bool isEnglishSelected=false;
  bool isArabicSelected=false;

  setLanguage(){
    saveLanguage(isEnglishSelected?'en':'ar');

    MyApp.of(context)!.setLocale( Locale.fromSubtags(languageCode: isEnglishSelected ? 'en' : 'ar'));

  }

@override
  void initState() {
    // TODO: implement initState
  _loadCheckBoxState();
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      shape: circularBorder,
      elevation: 5.0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Language",style: upStyle,),
                  CustomIconButton(
                    isIcon: false,
                    iconColor: redColor,
                    height: 20.0,
                    width: 20.0,
                    icon: Icons.close,
                    onTap: (){
                      Navigator.pop(context);
                    },

                  ),


                ],
              ),
            ),
            divider,
            CheckboxListTile(
              value: isEnglishSelected,
              onChanged: (value){
                isEnglishSelected=value!;
                isArabicSelected=false;
                setState(() {
                  setLanguage();
                  _saveCheckBoxState();
                });
              },
              title: Text("English",style: langStyle,),
            ),
            CheckboxListTile(value: isArabicSelected,
              onChanged:(value){
                isArabicSelected=value!;
                isEnglishSelected=false;
                setState(() {
                  setLanguage();
                  _saveCheckBoxState();
                });
              },
              title: Text("Arabic",style: langStyle,),
            ),

            // LanguageWidget(
            //   langText: "English",
            // ),
            // LanguageWidget(
            //   langText: "Arabic",
            // ),
            Divider(color: Colors.transparent,)

          ],
        ),
      ),
    );
  }
  _loadCheckBoxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool value1 = (prefs.getBool('checkBoxValue1') ?? false);
      isEnglishSelected=value1;

      bool value2 = (prefs.getBool('checkBoxValue2') ?? false);
      isArabicSelected=value2;
    });
  }

  _saveCheckBoxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('checkBoxValue1', isEnglishSelected);
    prefs.setBool('checkBoxValue2', isArabicSelected);
  }



}