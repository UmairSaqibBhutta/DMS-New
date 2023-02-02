
import 'package:dms_new_project/Auth/login_screen.dart';
import 'package:dms_new_project/Screens/app_screens/dashboard_module/doc_search_screen.dart';
import 'package:dms_new_project/Screens/app_screens/folders_module/doc_categories_screen.dart';
import 'package:dms_new_project/Screens/app_screens/folders_module/doc_subfolders_screen.dart';
import 'package:dms_new_project/configs/colors.dart';
import 'package:dms_new_project/helper_services/custom_loader.dart';
import 'package:dms_new_project/helper_services/custom_snackbar.dart';
import 'package:dms_new_project/helper_services/navigation_services.dart';
import 'package:dms_new_project/helper_widgets/custom_dd_decoration_widget.dart';
import 'package:dms_new_project/helper_widgets/custom_drop_down_text.dart';
import 'package:dms_new_project/helper_widgets/custom_icon_button.dart';
import 'package:dms_new_project/helper_widgets/custom_textfield.dart';
import 'package:dms_new_project/models/folders_model.dart';
import 'package:dms_new_project/providers/categories_list_provider.dart';
import 'package:dms_new_project/providers/folers_provider.dart';
import 'package:dms_new_project/providers/user_data_provider.dart';
import 'package:dms_new_project/services/categories_list_service.dart';
import 'package:dms_new_project/services/doc_search_service.dart';
import 'package:dms_new_project/services/folder_service.dart';
import 'package:dms_new_project/utils/app_localization.dart';
import 'package:dms_new_project/utils/constants.dart';
import 'package:dms_new_project/utils/local_storage_service/save_user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../configs/constants.dart';
import '../../../configs/text_styles.dart';
import '../../../providers/doc_search_provider.dart';
import '../../../utils/dialogs/language_change_dialog.dart';
import '../../../utils/handlers.dart';
import '../folders_module/folder_card_view_widget.dart';

class HomeDashBoardScreen extends StatefulWidget {
  const HomeDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<HomeDashBoardScreen> createState() => _HomeDashBoardScreenState();
}

class _HomeDashBoardScreenState extends State<HomeDashBoardScreen> {
  int? selectedCat;
final TextEditingController searchCont=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCatHandler(context:context);

      getFoldersHandler(context: context, roleName: "Admin");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: whiteColor,

      appBar: AppBar(
      leading:  CustomIconButton(
        width: 50.0,
        isIcon: false,
        iconColor: appColor,
        height: 20.0,
        icon: Icons.language_outlined,
        onTap: (){
          languageChangeDialog(

          );
        },
      ),
        backgroundColor: whiteColor,
        title: Text(AppLocalizations.of(context)!.translate(HOMEDASHBOARD).toString(),style: dashStyle,),

        actions: [

          CustomIconButton(
            isIcon: false,
            iconColor: redColor,
            height: 20.0,
            onTap: ()async{

              SharedPreferences pref=await SharedPreferences.getInstance();
              pref.clear();
              NavigationServices.goNextAndDoNotKeepHistory(context: context, widget: LoginScreen());

            },
            icon: Icons.logout,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomDropDownText(
                  text: AppLocalizations.of(context)!.translate(SelectCat).toString(),
                ),
          Consumer<CategoriesListProvider>(builder: (context,cat,_){
            return
         CustomDropDownDecorationWidget(
           selectedColor: selectedCat==null?false:true,
           child: DropdownButton(
               value: selectedCat,
               underline: SizedBox(),
               isExpanded: true,
               hint: Text( AppLocalizations.of(context)!.translate(SelectCat).toString(),),
               items: cat.catList!.map((item){
                 return DropdownMenuItem(
                   child:Text(item.name??""),
                   value: item.documentCategoryId,
                 );
               } ).toList(),
               onChanged: (int? value){
                 selectedCat=value!;
                 setState(() {

                 });
               }),
         );
          }),
                CustomTextField(
                  headerText: AppLocalizations.of(context)!.translate(SearchDoc).toString(),
                  hintText: "Search",
                  controller: searchCont,
                  suffixIcon: Icons.search,
                  suffixOnTap: (){
                    selectedCat!=null?
                    NavigationServices.goNextAndKeepHistory(context: context, widget: DocSearchScreen(searchText: searchCont.text,catId: selectedCat??0,)):
                    CustomSnackBar.failedSnackBar(context: context, message: "Select Category First");
                    searchCont.clear();
                  },
                  onSubmit: (value){
                    selectedCat!=null?
                    NavigationServices.goNextAndKeepHistory(context: context, widget: DocSearchScreen(searchText: searchCont.text,catId: selectedCat??0,)):
                    CustomSnackBar.failedSnackBar(context: context, message: "Select Category First");
                    searchCont.clear();
                  },
                ),
           
                Consumer<FoldersProvider>(builder: (context,fold,_){
                  List<Widget> widgets=[];
                  fold.foldList!=null? fold.foldList!.forEach((element) {
                    widgets.add(FolderCardView(
                      foldName: element.name??"",
                      onTap: (){
                        element.docSubFolders!=null?NavigationServices.goNextAndKeepHistory(context: context, widget: DocSubFoldersScreen(
                          docSubFolders: element.docSubFolders,
                        )):
                        NavigationServices.goNextAndKeepHistory(context: context, widget: DocCategoriesScreen(
                          docCategory: element.documentCategory,
                        ));
                      },
                    ));
                  }):Text("No Folder exsist");
                  return Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: widgets,
                    ),
                  );
                })


              ],
            ),
          ),
        ),
      ),
    );
  }

   languageChangeDialog() {
    return showDialog(context: context, builder: (context){
      return LanguageChangeDialogScreen();
    });
   }
}

