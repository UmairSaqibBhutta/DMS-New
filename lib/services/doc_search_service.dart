
import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/helper_services/custom_post_request_service.dart';
import 'package:dms_new_project/models/doc_search_model.dart';
import 'package:dms_new_project/providers/doc_search_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DocSearchService{
  Future getSearch({required BuildContext context,required String searchText,required int catId})async{
    try{
      var res=await GetRequestService().httpGetRequest(context: context, url: docSearchUrl+"seacrh=$searchText&startDate=&endDate=&catId=$catId&page=1");
      if(res!=null){
        DocSearchModel docSearch=DocSearchModel.fromJson(res);
        Provider.of<DocSearchProvider>(context,listen: false).updateSearchList(
          newSearch: docSearch.data
        );
        return true;
      }
      else{
        return null;
      }
    }
        catch(err){
      print("Exception in Documents Search Service $err");
      return null;
        }
  }
}