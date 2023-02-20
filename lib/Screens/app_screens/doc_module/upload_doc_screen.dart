import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/helper_widgets/custom_textfield.dart';
import 'package:dms_new_project/helper_widgets/default_button.dart';
import 'package:dms_new_project/services/upload_doc_service.dart';
import 'package:dms_new_project/utils/local_storage_service/save_user_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants.dart';
import '../../../models/doc_list_model.dart';

class AddNewDocumentsScreen extends StatefulWidget {
  List<Attribute>? attribute;
  final int catId;

  AddNewDocumentsScreen({required this.attribute, required this.catId});

  @override
  State<AddNewDocumentsScreen> createState() => _AddNewDocumentsScreenState();
}

class _AddNewDocumentsScreenState extends State<AddNewDocumentsScreen> {
  List<TextEditingController> _controller = [];

  FilePickerResult? file;
  PlatformFile? pFile;

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 1; i <= widget.attribute!.length; i++)
      _controller.add(TextEditingController());
    super.initState();
  }

  bool isAttach = false;

  uploadDocHandler() async {
    CustomLoader.showLoader(context: context);
    int empId = await getEmpId();
    String userName = await getUserName();
    var res = await UploadDocumentService().uploadDoc(
      context: context,
      catId: widget.catId,
      notes: 'test by team',
      empId: empId,
      userName: '$userName',
      model: [0],
      attachments: pFile==null?null:pFile!.path,
      attributes: widget.attribute!,
      contList: _controller,
    );
    print("Pfile $pFile");
    print("Cat Id ${widget.catId}");
    CustomLoader.hideLoader(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: iconTheme,
        backgroundColor: whiteColor,
        title: Text(
          "Add New Documents",
          style: dashStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  itemCount: widget.attribute!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemBuilder: (BuildContext, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.attribute![index].name}"),
                        CustomTextField(
                          controller: _controller[index],
                        )
                      ],
                    );
                  }),
              divider,
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: DottedBorder(
                      color: appColor,
                      dashPattern: [8, 6],
                      // strokeWidth: 8,
                      padding: EdgeInsets.all(8),
                      borderPadding: EdgeInsets.all(4),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(pFile != null
                                ? "${pFile!.path!.split("/").last}"
                                : ""),
                            CustomIconButton(
                              onTap: () {
                                uploadFile();
                              },
                              text: "Choose File",
                              fontSize: 12.0,
                              iconColor: appColor,
                              bgColor: whiteColor,
                              borderColor: appColor,
                              height: 40.0,
                              icon: Icons.file_copy,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              divider,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(border: Border.all(color: black26)),
        height: kToolbarHeight * 1.1,
        width: double.infinity,
        child: Column(
          children: [
            DefaultButton(
                height: 38.0,
                text: "Upload Documents",
                width: 200.0,
                onTap: () async {
                  await uploadDocHandler();

                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }

  uploadFile() async {
    file = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mkv'],
    );
    setState(() {});
    if (file != null) {
      pFile = file!.files.first;
      print("There Path ${pFile!.path}");
      print('My Path ${file!.paths}');
    }
  }
}
