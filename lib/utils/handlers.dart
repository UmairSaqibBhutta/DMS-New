import 'package:dms_new_project/services/attach_doc_service.dart';
import 'package:flutter/cupertino.dart';

import '../helper_services/custom_loader.dart';
import '../services/categories_list_service.dart';
import '../services/doc_search_service.dart';
import '../services/doc_view_service.dart';
import '../services/folder_service.dart';
import 'local_storage_service/save_user_service.dart';

getCatHandler({required BuildContext context})async{
  CustomLoader.showLoader(context: context);
  await CategoriesListService().getCat(context: context);
  CustomLoader.hideLoader(context);
}
docSearchHandle({required BuildContext context,required String searchText,required int catId})async{
  CustomLoader.showLoader(context: context);
  await DocSearchService().getSearch(context: context, searchText: searchText, catId: catId);
  CustomLoader.hideLoader(context);
}
getFoldersHandler({required BuildContext context,required String roleName})async{
  CustomLoader.showLoader(context: context);
  int empId=await getEmpId();
  await FoldersService().getFolders(context: context, empId: empId, roleName: roleName);
  CustomLoader.hideLoader(context);
}
docViewHandler({required BuildContext context,required String filePath})async{
  CustomLoader.showLoader(context: context);
  await DocViewService().viewDoc(context: context, filePath: "$filePath");
  CustomLoader.hideLoader(context);
}

