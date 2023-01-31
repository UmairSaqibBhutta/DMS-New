

import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/models/doc_view_model.dart';
import 'package:dms_new_project/providers/doc_view_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DocViewService{
  Future viewDoc({required BuildContext context,required String filePath})async{
    try{
      var res=await GetRequestService().httpGetRequest(context: context, url: docViewUrl+"filepath=$filePath");
      if(res!=null){
        DocViewModel docView=DocViewModel.fromJson(res);
        Provider.of<DocViewProvider>(context,listen: false).updateDocView(
          newView: docView
        );
        return true;
      }
      else{
        return null;
      }
    }
        catch(err){
      print("Exception in documents view service $err");
      return null;
        }
  }
}