

import 'package:flutter/material.dart';

import '../models/CategorisListModel.dart';

class CategoriesListProvider extends ChangeNotifier{
  List<CategoriesList>? catList=[];
  updateCat({List<CategoriesList>? newCat}){
    catList=newCat;
    notifyListeners();
  }
}