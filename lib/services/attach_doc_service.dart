

import 'dart:convert';
import 'dart:io';

import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AttachDocService{

  Future attachDoc({required BuildContext context,required int docId,required int empId,required String userName,required String attachments})async{
    try{
      Map<String,String> _body=<String,String>{
        "DocumentId":'$docId',
        "EmployeeId":'$empId',
        "CurrentUserName":'$userName',
        "attachments":attachments
      };
      var request = http.MultipartRequest('POST', Uri.parse(attachDocUrl))
        ..fields.addAll(_body);
      request.files.add(
          http.MultipartFile(
              'picture',
              File(attachments).readAsBytes().asStream(),
              File(attachments).lengthSync(),
              filename: attachments.split("/").last
          )
      );
    
      var response=await request.send();
     
      final body=await response.stream.bytesToString();


      var jsonDecoded=json.decode("My Body $body");

      if(jsonDecoded==null){
        print("Attachments Not Uploaded");
        CustomSnackBar.failedSnackBar(context: context, message: jsonDecoded['Message']);
      }
      else{
        CustomSnackBar.showSnackBar(context: context, message: jsonDecoded['Message']);

        print("Attachments Uploaded Successfully");
        return jsonDecoded;
      }

    }
        catch(err){
      print("Exception in attach doc service $err");
      return null;
        }
  }
}