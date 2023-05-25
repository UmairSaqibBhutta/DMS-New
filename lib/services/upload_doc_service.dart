import 'dart:developer';
import 'dart:io';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../configs/api_configs.dart';
import '../models/doc_list_model.dart';

class UploadDocumentService {
  Future uploadDoc({
    bool isAttach = false,
    required int catId,
    required String notes,
    required int empId,
    required String userName,
    required List model,
    required BuildContext context,
    String? attachments,
    required List<Attribute> attributes,
    required List<TextEditingController> contList,
  }) async {
    try {
      Map<String, String> requestBody = <String, String>{
        'CategoryId': '$catId',
        'notes': notes,
        'EmployeeId': '$empId',
        'CurrentUserName': userName,
        'model': '$model',
        'attachments': '$attachments'
      };

      for (int i = 0; i < attributes.length; i++) {
        //key   value//
        requestBody['${attributes[i].name}'] = contList[i].text;
      }

      var request = http.MultipartRequest('POST', Uri.parse(uploadDocUrl))
        ..fields.addAll(requestBody);

      attachments != null
          ? request.files.add(http.MultipartFile(
              'picture',
              File(attachments).readAsBytes().asStream(),
              File(attachments).lengthSync(),
              filename: attachments.split("/").last,
            ))
          : null;
      // var response = await request.send();
      await request.send().then((value) async {
        http.Response.fromStream(value).then((response) async {
          final responseString = response.body;
          if (response.statusCode == 200) {
            log("upload succesfull");
            log("response.statusCode = ${response.statusCode}");
            log("response body $responseString");

            CustomSnackBar.showSnackBar(
                context: context, message: "Uploaded Successfully");
          } else {
            log("not Uploaded");
            log("response body $responseString");
            log("${response.statusCode}");
            log("$response");
            CustomSnackBar.showSnackBar(
                context: context, message: "Error in Uploading");
          }
        });
      });
    } catch (err) {
      log("Exception in upload documnet servoce $err");
      return null;
    }
  }
}
