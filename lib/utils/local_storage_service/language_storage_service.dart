


import 'package:shared_preferences/shared_preferences.dart';

Future saveLanguage(bool language)async{

  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setBool('language', language);
  print("Saved");

}
Future getLanguage()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  return pref.getBool('language');
}