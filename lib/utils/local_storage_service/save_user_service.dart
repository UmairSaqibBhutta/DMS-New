
import 'dart:convert';

import 'package:dms_new_project/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveUser(String user)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  pref.setString('user', user);
  return true;
}
getUser()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
 return  pref.getString('user');
}

getEmpId()async{
  String empId=await getUser();
  UserModel user=UserModel.fromJson(json.decode(empId));
  print("Emp Id ${user.empId}");
  return user.empId;
}