
import 'package:flutter/material.dart';

import '../models/doc_search_model.dart';

class DocSearchProvider extends ChangeNotifier{
  List<SearchList>? searchList=[];
  updateSearchList({List<SearchList>? newSearch}){
    searchList=newSearch;
    notifyListeners();
  }
}