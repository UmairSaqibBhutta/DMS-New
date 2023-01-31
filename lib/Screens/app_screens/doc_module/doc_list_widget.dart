import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/helper_services/navigation_services.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/models/doc_list_model.dart';
import 'package:flutter/material.dart';

import '../../../configs/constants.dart';
import '../../../configs/text_styles.dart';
import '../../../utils/dialogs/status_pending_dialog.dart';
import 'doc_view_screen.dart';

class DocListWidget extends StatelessWidget {
  DocumentsList doc;

  DocListWidget({required this.doc});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: circularBorder,
      elevation: 10.0,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         SizedBox(
           height: 50.0,
           child: ListView.builder(
               itemCount: doc.attribute!.length,
               shrinkWrap: true,
               primary: false,
               scrollDirection: Axis.horizontal,
               itemBuilder: (BuildContext,index){
             return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 6.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("${doc.attribute![index].name}",style: headerStyle,),
                   Text("${doc.attribute![index].value}",style: attStyle,),
                 ],
               ),
             );
           }),
         ),
          Card(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
              side: BorderSide(color: appColor)
            ),
            margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            elevation: 4.0,
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                leading: Image.asset(
                  doc.documentType=="JPG"?jpg:
                  doc.documentType=="PDF"?pdf:
                  doc.documentType=="JPEG"?jpg:
                  doc.documentType=="XLS"?xls:
                  doc.documentType=="XLSX"?xls:
                  doc.documentType=="PPTX"?ppt:
                  png
                        ),
                title: Text("${doc.uploadedBy}"),
            subtitle: Text("${doc.uploadedDate}"),
            trailing: InkWell(
              onTap: (){
                doc.attachmentStatus=="Complete"?NavigationServices.goNextAndKeepHistory(context: context, widget: DocViewScreen(
                  filePath: doc.noofVersions??"",
                )):
                    showPendingDialog(context);
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      border: Border.all(
                          color: doc.attachmentStatus == "Complete"
                              ? greenColor
                              : redColor,
                          width: 1.5)),
                  child: Text(
                    "${doc.attachmentStatus}",
                    style: compStyle,
                  )),
            ),
          ),),
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
    );
  }

}
