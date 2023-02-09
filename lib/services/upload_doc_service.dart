import 'dart:convert';
import 'dart:io';

import 'package:dms_new_project/helper_services/custom_post_request_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../configs/api_configs.dart';

class UploadDocumentService {
  Future uploadDoc(
      {required int catId,
      required String notes,
      required int empId,
      required String userName,
      required List model,
      required BuildContext context,
      required String attachments,
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

      var request = http.MultipartRequest('POST', Uri.parse(uploadDocUrl))
        ..fields.addAll(requestBody);
      request.files.add(
          http.MultipartFile(
              'picture',
              File(attachments).readAsBytes().asStream(),
              File(attachments).lengthSync(),
              filename: attachments.split("/").last
          )
      );
      var response = await request.send();
      final respStr = await response.stream.bytesToString();

      var jsonDecoded=json.decode("Body ${respStr}");

      if (jsonDecoded==null) {
        print("Doc not Uploaded");
        return true;
      } else {

        print("DOc Uploaded Successfully");
        return jsonDecoded;
      }
    } catch (err) {
      print("Exception in upload documnet servoce $err");
      return null;
    }
  }
}
