import 'package:dms_new_project/Screens/app_screens/folders_module/doc_categories_screen.dart';
import 'package:dms_new_project/Screens/app_screens/dashboard_module/home_dashboard_screen.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/configs/text_styles.dart';
import 'package:dms_new_project/helper_services/navigation_services.dart';
import 'package:flutter/material.dart';

import '../../../models/folders_model.dart';
import 'folder_card_view_widget.dart';

class DocSubFoldersScreen extends StatefulWidget {
  List<DocSubFolders>? docSubFolders;
   DocSubFoldersScreen({required this.docSubFolders});

  @override
  State<DocSubFoldersScreen> createState() => _DocSubFoldersScreenState();
}

class _DocSubFoldersScreenState extends State<DocSubFoldersScreen> {



  @override
  Widget build(BuildContext context) {
    List<Widget> widgets=[];
    widget.docSubFolders!.forEach((element) {
      widgets.add(FolderCardView(foldName: element.name??"",
        onTap: (){
        element.docSubFolders==null?
        NavigationServices.goNextAndKeepHistory(context: context, widget: DocCategoriesScreen(
          docCategory: element.documentCategory,
        )):
        NavigationServices.goNextAndKeepHistory(context: context, widget: DocSubFoldersScreen(docSubFolders: element.docSubFolders));
            ;
        },
      ));

    });
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Documents SubFolders",style: dashStyle,),
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Wrap(
        children: widgets,
      ),


    );
  }
}
