


import 'package:shared_preferences/shared_preferences.dart';

Future saveLanguage(String language)async{

  SharedPreferences pref=await SharedPreferences.getInstance();
  print("saving the language = $language");
  pref.setString('language', language);
  print("Saved Here");

}
Future getLanguage()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  print("Geted");
  String ?isEng = await pref.getString('language');
  print("getting the language as : $isEng");
  if(isEng==null){
    return true;
  }else{
    return isEng;
  }


}

