
import 'package:flutter/material.dart';

import '../models/doc_list_model.dart';

class DocListProvider extends ChangeNotifier{
  List<DocumentsList>? docList=[];

  updateDoc({List<DocumentsList>? newDoc}){
    docList=newDoc;
    notifyListeners();
  }
}