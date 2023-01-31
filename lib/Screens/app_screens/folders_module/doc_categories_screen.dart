
import 'package:dms_new_project/Screens/app_screens/doc_module/doc_list_screen.dart';
import 'package:dms_new_project/Screens/app_screens/dashboard_module/home_dashboard_screen.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/constants.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/navigation_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/folders_model.dart';
import 'folder_card_view_widget.dart';

class DocCategoriesScreen extends StatefulWidget {
  List<DocumentCategory>? docCategory;
   DocCategoriesScreen({required this.docCategory});

  @override
  State<DocCategoriesScreen> createState() => _DocCategoriesScreenState();
}

class _DocCategoriesScreenState extends State<DocCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets=[];
    widget.docCategory?.forEach((element) {
      widgets.add(FolderCardView(foldName: element.name??"",
      onTap: (){
        NavigationServices.goNextAndKeepHistory(context: context, widget: DocListScreen(
          catId: element.documentCategoryId??0,
        ));
      },
      ),);
    });
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        iconTheme: iconTheme,
        backgroundColor: whiteColor,
        title: Text("Documents Categories",style: dashStyle,),

      ),
      body:SafeArea(
        child: widget.docCategory!=null? Wrap(
          children: widgets,
        ):Center(child: Text("No category available against this record",style: catStyle,)),

      )
    );
  }
}
