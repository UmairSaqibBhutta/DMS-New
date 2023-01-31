
import 'package:dms_new_project/models/doc_view_model.dart';
import 'package:flutter/material.dart';

class DocViewProvider extends ChangeNotifier{
  DocViewModel? docView;
  updateDocView({DocViewModel ? newView}){
    docView=newView;
    notifyListeners();
  }
}