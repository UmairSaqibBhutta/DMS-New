import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/models/doc_list_model.dart';
import 'package:dms_new_project/providers/doc_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../configs/api_configs.dart';

class DocumentsListService extends ChangeNotifier {
  List<DocumentsList>? docList = [];
  int pageNo = 1;

  Future getInitDoc({required BuildContext context, required int catId,})async{
    try{
     await getMoreDocs(context: context, catId: catId);
    }
        catch(err){
      print("Exception in get init doc list service $err");
        }
  }

  Future getMoreDocs({required BuildContext context, required int catId,
  }) async {
    try {
      var res = await GetRequestService().httpGetRequest(
          context: context, url: docListUrl + "id=$catId&page=$pageNo");
      if (res != null) {
        DocListModel docListModel = DocListModel.fromJson(res);
        // Provider.of<DocListProvider>(context,listen: false).updateDoc(
        //   newDoc: docList.data
        // );
        if (pageNo == 1 || docList == []) {
          // docList.add(docListModel);
          docList = docListModel.data;
        } else {
          docList!.addAll(docListModel.data!);
          print("Page No $pageNo");
        }
        notifyListeners();
        return true;
      }
    } catch (err) {
      print("Exception in Documents List Service $err");
      return null;
    }
  }
}
