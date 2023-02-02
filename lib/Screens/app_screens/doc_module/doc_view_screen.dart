
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/constants.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/helper_widgets/default_button.dart';
import 'package:dms_new_project/models/doc_view_model.dart';
import 'package:dms_new_project/providers/doc_view_provider.dart';
import 'package:dms_new_project/services/doc_view_service.dart';
import 'package:dms_new_project/utils/handlers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../configs/text_styles.dart';

// class DocViewScreen extends StatefulWidget {
//   final String filePath;
//    DocViewScreen({required this.filePath}) ;
//
//   @override
//   State<DocViewScreen> createState() => _DocViewScreenState();
// }
//
// class _DocViewScreenState extends State<DocViewScreen> {
//   docViewHandler()async{
//     CustomLoader.showLoader(context: context);
//     await DocViewService().viewDoc(context: context, filePath: "${widget.filePath}");
//     CustomLoader.hideLoader(context);
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       docViewHandler();
//     });
//
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       appBar: AppBar(
//         backgroundColor: whiteColor,
//         iconTheme: iconTheme,
//         title: Text("Documents View",style: dashStyle),
//       ),
//       body: SafeArea(
//         child: Consumer<DocViewProvider>(builder: (context,view,_){
//           return view.docView!=null?
//               DocViewWidget(doc: view.docView!,fileName: widget.filePath,)
//               :Text("No Doc Available Here");
//         },),
//       ),
//       bottomNavigationBar: Container(
//         decoration: boxDecoration,
//         height: kToolbarHeight * 1.0,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CustomIconButton(
//               icon: Icons.preview,
//               text: "Show Preview",
//               width: 150.0,
//               height: 35.0,
//               borderColor: appColor,
//               iconColor: appColor,
//               fontSize: 12.0,
//               bgColor: whiteColor,
//               onTap: (){
//
//
//               },
//
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// }
class DocViewWidget extends StatefulWidget {
  final String fileName;
  DocViewWidget({ required this.fileName});

  @override
  State<DocViewWidget> createState() => _DocViewWidgetState();
}

class _DocViewWidgetState extends State<DocViewWidget> {

  String filePath='';
 late DocViewModel doc;


  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      docViewHandler(context: context, filePath:widget.fileName );
    });
    doc=Provider.of<DocViewProvider>(context,listen: false).docView!;
    print("Doc $doc");
    _createFileFromBase64();


    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: DefaultButton(
          onTap: (){
            OpenFile.open(filePath);
          },
        ),
      ),
    );
  }

  Future<String> _createFileFromBase64() async {
    final encodedStr = "${doc.data}";
    Uint8List bytes = base64.decode(encodedStr);
    String dir = (await getApplicationDocumentsDirectory()).path;
    // File file = File(
    //
    //   "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() +".pdf"+".mkv",
    // );
    File file = File(
      // "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
        "$dir/" + widget.fileName);

    await file.writeAsBytes(bytes);
    filePath= file.path;

    setState(() {

    });
    return filePath;
  }
}
