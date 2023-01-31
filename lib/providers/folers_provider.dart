
import 'package:flutter/material.dart';

import '../models/folders_model.dart';

class FoldersProvider extends ChangeNotifier{
  List<FoldersList>? foldList=[];
  updateFolders({List<FoldersList>? newFold}){
    foldList=newFold;
    notifyListeners();
  }
}