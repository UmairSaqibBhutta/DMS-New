import 'dart:convert';

import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class PostRequestService {
  Future httpPostRequest(
      {required BuildContext context,
      required String url,
      required Map body}) async {
    print("Url $url");
    try {
      http.Response response = await http.post(Uri.parse(url), body: body);
      print("Post request body ${response.body}");
      print("Post Request status code ${response.statusCode}");
      var jsonDecoded=json.decode(response.body);
      if (jsonDecoded==null || jsonDecoded['ResultType']!=1) {
        CustomSnackBar.failedSnackBar(context: context, message: jsonDecoded['Message']);
        return null;
      } else
        return jsonDecoded;
    } catch (err) {
      print("Exception Custom Post Request service $err");
      return null;
    }
  }
}