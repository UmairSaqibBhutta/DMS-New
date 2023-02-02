import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dms_new_project/models/doc_view_model.dart';
import 'package:path_provider/path_provider.dart';

createFileFromBase64({required DocViewModel view,required String filePath,required String fileName}) async {
  final encodedStr = "${view.data}";

  Uint8List bytes = base64.decode(encodedStr);

  String dir = (await getApplicationDocumentsDirectory()).path;

  File file = File(
    // "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      "$dir/" + fileName);

  await file.writeAsBytes(bytes);
  filePath = file.path;

  print("fILE 1 $filePath");
  return filePath;

  // return filePath;
}

