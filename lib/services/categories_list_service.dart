
import 'dart:convert';

import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/models/CategorisListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../configs/api_configs.dart';
import '../providers/categories_list_provider.dart';
class CategoriesListService{
  Future getCat({required BuildContext context})async {
    try{
      var res=await GetRequestService().httpGetRequest(context: context, url: catListUrl);
      if(res!=null){
        CategoriesModel categoriesModel=CategoriesModel.fromJson(res);
        Provider.of<CategoriesListProvider>(context,listen: false).updateCat(
          newCat: categoriesModel.data
        );
        return true;
      }
      else{
        return null;
      }
    }
        catch(err){
      print("Exception in get categories service $err");
      return null;
        }
  }
}