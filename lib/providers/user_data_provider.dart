
import 'package:dms_new_project/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier{
  UserModel? user;
  updateUser({UserModel? newUser}){
    user=newUser;
    notifyListeners();
  }
}