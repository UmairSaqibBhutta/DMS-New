
import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/models/doc_list_model.dart';
import 'package:dms_new_project/providers/doc_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../configs/api_configs.dart';

class DocumentsListService {


  Future getDocs({required BuildContext context,required int catId,})async{
    try{
      var res=await GetRequestService().httpGetRequest(context: context, url: docListUrl+"id=$catId&page=");
      if(res!=null){
        DocListModel docList=DocListModel.fromJson(res);
        Provider.of<DocListProvider>(context,listen: false).updateDoc(
          newDoc: docList.data
        );
        return true;
      }
      else{
        return null;
      }
    }
        catch(err){
      print("Exception in Documents List Service $err");
      return null;
        }
  }
}