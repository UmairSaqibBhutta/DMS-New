
import 'dart:convert';

import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart'as http;

class GetRequestService{
  Future httpGetRequest({required BuildContext context,required String url})async{
    print("get Request Url $url");
    try{
      http.Response response=await http.get(Uri.parse(url));
      print("Get Request Status Code ${response.statusCode}");
      print("Get Request  Body ${response.body}");
      var jsonDecoded=json.decode(response.body);
      if(response.statusCode!=200){
       
        CustomSnackBar.failedSnackBar(context: context, message: jsonDecoded['Message']);
        return null;
      }
      else{
        return jsonDecoded;
      }
    }
    catch(err){
      print("Exception in Custom get request service $err");
      return null;
    }
  }
}