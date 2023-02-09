import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';

import 'package:dms_new_project/models/doc_list_model.dart';
import 'package:dms_new_project/utils/handlers.dart';
import 'package:dms_new_project/utils/local_storage_service/save_user_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../configs/constants.dart';
import '../../../configs/text_styles.dart';
import '../../../helper_services/custom_loader.dart';
import '../../../models/doc_view_model.dart';
import '../../../providers/doc_view_provider.dart';
import '../../../services/attach_doc_service.dart';
import '../../../utils/dialogs/status_pending_dialog.dart';


class DocListWidget extends StatefulWidget {
  DocumentsList doc;

  DocListWidget({required this.doc});

  @override
  State<DocListWidget> createState() => _DocListWidgetState();
}

class _DocListWidgetState extends State<DocListWidget> {
  String filePath = '';
  DocViewModel? view;
  PickedFile? cameraFile;
FilePickerResult? pickFile;

  attachDocHandler(String path) async {
    CustomLoader.showLoader(context: context);
    int empId = await getEmpId();
    String userName = await getUserName();
    await AttachDocService().attachDoc(
        context: context,
        docId: widget.doc.documentId!,
        empId: empId,
        userName: userName,
        attachments: "$path");
    CustomLoader.hideLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: circularBorder,
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: widget.doc.attribute!.length == 0 ? 0.0 : 50.0,
            child: ListView.builder(
                itemCount: widget.doc.attribute!.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.doc.attribute![index].name}",
                          style: headerStyle,
                        ),
                        Text(
                          "${widget.doc.attribute![index].value}",
                          style: attStyle,
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: appColor)),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            elevation: 4.0,
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              leading: Image.asset(widget.doc.documentType == "JPG"
                  ? jpg
                  : widget.doc.documentType == "PDF"
                      ? pdf
                      : widget.doc.documentType == "JPEG"
                          ? jpg
                          : widget.doc.documentType == "XLS"
                              ? xls
                              : widget.doc.documentType == "XLSX"
                                  ? xls
                                  : widget.doc.documentType == "PPTX"
                                      ? ppt
                                      : placeHolder),
              title: Text("${widget.doc.uploadedBy}"),
              subtitle: Text("${widget.doc.uploadedDate}"),
              trailing: InkWell(
                onTap: () async {
                  if (widget.doc.attachmentStatus == "Complete") {
                    await docViewHandler(
                        context: context,
                        filePath: widget.doc.noofVersions ?? "");
                    view = Provider.of<DocViewProvider>(context, listen: false)
                        .docView!;
                    await _createFileFromBase64();

                    log("file path = $filePath");
                    view!.data != null
                        ? OpenFile.open(filePath)
                        : CustomSnackBar.failedSnackBar(
                            context: context, message: "File is incorrect");
                  } else {
                    showPendingDialog(
                      context: context,
                      cameraOnTap: () async {
                        await takePicture();
                        setState(() {
                          attachDocHandler(
                              cameraFile!.path
                          );
                        });
                      },
                      chooseOnTap: (){
                        chooseFile();
                      }
                    );
                  }
                },
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        border: Border.all(
                            color: widget.doc.attachmentStatus == "Complete"
                                ? greenColor
                                : redColor,
                            width: 1.5)),
                    child: Text(
                      "${widget.doc.attachmentStatus}",
                      style: compStyle,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _createFileFromBase64() async {
    final encodedStr = "${view!.data}";

    Uint8List bytes = base64.decode(encodedStr);

    String dir = (await getApplicationDocumentsDirectory()).path;

    File file = File(
        // "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
        "$dir/" + widget.doc.noofVersions!);

    await file.writeAsBytes(bytes);
    filePath = file.path;
    setState(() {});
    print("fILE 1 $filePath");
    return filePath;

    // return filePath;
  }

  takePicture() async {
    cameraFile = await ImagePicker().getImage(source: ImageSource.camera);
    print("My Path ${cameraFile!.path}");
  }

  chooseFile() async {
    pickFile = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4', 'mkv'],
    );
    if (pickFile != null) {
      PlatformFile file = pickFile!.files.first;
      attachDocHandler(
        "${file.path}"
      );
      print("file.path ${file.path}");
    }
  }
}
