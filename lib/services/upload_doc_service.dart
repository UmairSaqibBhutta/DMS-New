import 'dart:convert';
import 'dart:io';

import 'package:dms_new_project/helper_services/custom_post_request_service.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../configs/api_configs.dart';
import '../models/doc_list_model.dart';

class UploadDocumentService {
  Future uploadDoc(
      {bool isAttach=false,
        required int catId,
      required String notes,
      required int empId,
      required String userName,
      required List model,
      required BuildContext context,
      required String attachments,
      required List<Attribute> attributes,
        required List<TextEditingController> contList,
      }) async {
    try {



      Map<String, String> requestBody = <String, String>{
        'CategoryId': '$catId',
        'notes': '$notes',
        'EmployeeId': '$empId',
        'CurrentUserName': '$userName',
        'model': '$model',
        'attachments':'$attachments'
      };

      for(int i=0; i<attributes.length;i++){
        //key   value//
        requestBody['${attributes[i].name}']=contList[i].text;
      }

      var request = http.MultipartRequest('POST', Uri.parse(uploadDocUrl))
        ..fields.addAll(requestBody);
      request.files.add(
          http.MultipartFile(
              'picture',
              File(attachments).readAsBytes().asStream(),
              File(attachments).lengthSync(),
              filename: attachments.split("/").last,
          )

      );
      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      print("request body ${respStr}");
      if(response.statusCode==200){
        CustomSnackBar.showSnackBar(context: context, message: "Document Uploaded Successfully");
      }
      else{
        CustomSnackBar.failedSnackBar(context: context, message: "Documents Not Uploaded");
      }
      var jsonDecoded=json.decode("Body ${requestBody}");


    } catch (err) {
      print("Exception in upload documnet servoce $err");
      return null;
    }
  }
}
