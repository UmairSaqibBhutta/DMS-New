import 'dart:convert';
import 'dart:developer';

import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:dms_new_project/helper_services/internet_connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class GetRequestService {
  Future httpGetRequest(
      {required BuildContext context, required String url}) async {
    log("get Request Url $url");
    try {
      if (await hasNetwork()) {
        http.Response response = await http.get(Uri.parse(url));
        log("Get Request Status Code ${response.statusCode}");
        log("Get Request  Body ${response.body}");
        var jsonDecoded = json.decode(response.body);
        if (response.statusCode != 200) {
          CustomSnackBar.failedSnackBar(
              context: context, message: jsonDecoded['Message']);
          return null;
        } else {
          return jsonDecoded;
        }
      } else {
        CustomSnackBar.failedSnackBar(
            context: context, message: "Internet is slow or disconnected");
      }
    } catch (err) {
      log("Exception in Custom get request service $err");
      return null;
    }
  }
}
