import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AttachDocService {
  Future attachDoc(
      {required BuildContext context,
      required int docId,
      required int empId,
      required String userName,
      required String attachments}) async {
    try {
      Map<String, String> _body = <String, String>{
        "DocumentId": '$docId',
        "EmployeeId": '$empId',
        "CurrentUserName": userName,
        "attachments": attachments
      };

      log("body in attachDoc = $_body ");
      log("attachDocUrl in attachDoc = $attachDocUrl ");
      var request = http.MultipartRequest('POST', Uri.parse(attachDocUrl))
        ..fields.addAll(_body);

      request.files.add(http.MultipartFile(
        'picture',
        File(attachments).readAsBytes().asStream(),
        File(attachments).lengthSync(),
        filename: attachments.split("/").last,
      ));

      var response = await request.send();

      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        CustomSnackBar.showSnackBar(
            context: context, message: "Document Upload Successfully");

        return true;
      } else {
        CustomSnackBar.failedSnackBar(
            context: context, message: "Doc Not Uploaded");
      }
      var jsonDecoded = json.decode("My Body $body");
    } catch (err) {
      print("Exception in attach doc service $err");
      return null;
    }
  }
}
