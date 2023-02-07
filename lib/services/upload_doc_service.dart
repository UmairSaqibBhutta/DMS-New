import 'dart:convert';

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
      required BuildContext context}) async {
    try {



      Map<String, String> requestBody = <String, String>{
        'CategoryId': '$catId',
        'notes': '$notes',
        'EmployeeId': '$empId',
        'CurrentUserName': '$userName',
        'model': '$model',
      };

      var request = http.MultipartRequest('POST', Uri.parse(uploadDocUrl))
        ..fields.addAll(requestBody);
      var response = await request.send();
      final respStr = await response.stream.bytesToString();
      print(
        jsonDecode("respStr $respStr"),
      );



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
