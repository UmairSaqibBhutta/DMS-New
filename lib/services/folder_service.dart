
import 'package:dms_new_project/configs/api_configs.dart';
import 'package:dms_new_project/helper_services/custom_get_request_service.dart';
import 'package:dms_new_project/models/folders_model.dart';
import 'package:dms_new_project/providers/folers_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FoldersService{
  Future getFolders({required BuildContext context,required int empId,required String roleName})async{
    try{
      var res=await GetRequestService().httpGetRequest(context: context, url: foldersUrl+"EmployeeID=$empId&RoleName=$roleName");
      if(res!=null){
        FoldersModel folders=FoldersModel.fromJson(res);
        Provider.of<FoldersProvider>(context,listen: false).updateFolders(
          newFold: folders.data
        );
        return true;
      }
      else{
        return null;
      }
    }
        catch(err){
      print("Exception in get folders service $err");
      return null;
        }
  }
}