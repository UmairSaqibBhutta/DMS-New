import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

Future saveLanguage(String language) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  log("saving the language = $language");
  pref.setString('language', language);
  log("Saved Here");
}

Future getLanguage() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? isEng = pref.getString('language');
  log("getting the language as : $isEng");
  if (isEng == null) {
    return true;
  } else {
    return isEng;
  }
}
