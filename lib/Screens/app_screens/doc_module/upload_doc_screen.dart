import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/helper_widgets/custom_textfield.dart';
import 'package:dms_new_project/helper_widgets/default_button.dart';
import 'package:dms_new_project/services/upload_doc_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants.dart';
import '../../../models/doc_list_model.dart';

class AddNewDocumentsScreen extends StatefulWidget {
  List<Attribute>? attribute;
   AddNewDocumentsScreen({required this.attribute});

  @override
  State<AddNewDocumentsScreen> createState() => _AddNewDocumentsScreenState();
}

class _AddNewDocumentsScreenState extends State<AddNewDocumentsScreen> {
  List<TextEditingController> _controller = [];
  @override
  void initState() {
    // TODO: implement initState
    for (int i = 1; i <= widget.attribute!.length; i++) _controller.add(TextEditingController());
    super.initState();
  }

  uploadDocHandler()async{
    CustomLoader.showLoader(context: context);
    await UploadDocumentService().uploadDoc(context: context, catId: 39, notes: 'test by team', empId: 1000012, userName: 'l.lotfy', model: [0],);
    CustomLoader.hideLoader(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: iconTheme,
        backgroundColor: whiteColor,
        title: Text("Add New Documents",style: dashStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
       ListView.builder(
             itemCount: widget.attribute!.length,
             shrinkWrap: true,
             scrollDirection: Axis.vertical,
             primary: false,
             itemBuilder: (BuildContext,index){
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
                        width: MediaQuery.of(context).size.width/1.8,
                        height: MediaQuery.of(context).size.height*0.17,
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        CustomIconButton(

                          onTap: (){},
                          icon: Icons.camera,
                          bgColor: whiteColor,
                          borderColor: appColor,
                          text: "Camera",
                          fontSize: 12.0,
                          height: 40.0,
                          iconColor:appColor ,
                        ), CustomIconButton(
                          onTap: (){},
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
              divider
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(color: black26)
        ),
        height: kToolbarHeight * 1.1,
        width: double.infinity,
        child: Column(
          children: [
            DefaultButton(
              height: 38.0,
              text: "Upload Documents",
              width: 200.0,
              onTap: (){
                uploadDocHandler();
              },
            ),
          ],
        ),
      ),
    );
  }
}
