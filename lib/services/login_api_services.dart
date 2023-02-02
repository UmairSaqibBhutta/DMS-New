


import 'dart:convert';

import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_post_request_service.dart';

import 'package:dms_new_project/models/user_model.dart';
import 'package:dms_new_project/providers/user_data_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../utils/local_storage_service/save_user_service.dart';

class LoginApiService {
  Future getUser(
      {required BuildContext context, required String userName, required String password}) async {
    try {
      Map _body = {"UserName": userName, "Password": password};
  var res=await PostRequestService().httpPostRequest(context: context, url: loginUrl, body: _body);

      if (res!=null) {
        print("Inside");
        UserResponseModel userModel = UserResponseModel.fromJson(res);
        Provider.of<UserDataProvider>(context, listen: false).updateUser(
            newUser: userModel.data
        );

        saveUser(jsonEncode(userModel.data!.toJson()));
        print("Save User ${(jsonEncode(userModel.data!.toJson()))}");

        return true;
      }
      else
{

  return null;
}
    }

        catch(err){
      print("Exception in login api service $err");
      return null;
        }
  }
}