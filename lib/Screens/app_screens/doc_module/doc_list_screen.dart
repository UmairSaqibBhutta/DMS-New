import 'package:dms_new_project/Screens/app_screens/doc_module/add_new_doc.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/constants.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/providers/doc_list_provider.dart';
import 'package:dms_new_project/services/doc_list_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper_services/navigation_services.dart';
import 'doc_list_widget.dart';

class DocListScreen extends StatefulWidget {
 final  int catId;
  DocListScreen({required this.catId});

  @override
  State<DocListScreen> createState() => _DocListScreenState();
}

class _DocListScreenState extends State<DocListScreen> {
  getDocList()async{
    CustomLoader.showLoader(context: context);
    await DocumentsListService().getDocs(context: context, catId: widget.catId);
    CustomLoader.hideLoader(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getDocList();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        iconTheme: iconTheme,
        title: Text("Documents List",style: dashStyle,),
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Consumer<DocListProvider>(builder: (context,doc,_){
            return ListView.builder(
                shrinkWrap: true,
                itemCount: doc.docList!.length,
                primary: false,
                itemBuilder: (BuildContext,index){
              return DocListWidget(
                doc: doc.docList![index],
              );
            });
          },),
        ),
      ),
      floatingActionButton: FloatingActionButton(
      backgroundColor: appColor,
        onPressed: () {
        NavigationServices.goNextAndKeepHistory(context: context, widget: AddNewDocumentsScreen(
            attribute:Provider.of<DocListProvider>(context,listen: false).docList![0].attribute!,
        ));
        },
        child: Icon(Icons.add),

      ),
    );
  }

}
