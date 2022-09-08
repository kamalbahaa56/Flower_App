import 'package:flutter/material.dart';

import '../model/items.dart';

class Carrt with ChangeNotifier 
{
  List selectProduct =[];
  double Price = 0.0 ;

  AddProduct(ModelPaltes pproduct)
  {
   selectProduct.add(pproduct);
   Price += pproduct.Num.round();
   notifyListeners();
  }

  RemoveProdct(ModelPaltes pproduct)
  {
    selectProduct.remove(pproduct);
    Price-=pproduct.Num.round();
    notifyListeners();
  }
}



