import 'package:flutter/material.dart';

import 'Model/CategoriyaQT.dart';
import 'Model/ProductsModel.dart';

class ChangeNot with ChangeNotifier {
  List<CategoriyaModel> _currentPos;

  ChangeNot(this._currentPos);

  List<CategoriyaModel> get sana => _currentPos;

  set sana(List<CategoriyaModel> value) {
    _currentPos = value;
    notifyListeners();
  }


}
class ProductNoti with ChangeNotifier {
  ProductsMainPageModel  _currentPos;

  ProductNoti(this._currentPos);

  ProductsMainPageModel get sana => _currentPos;

  set sana(ProductsMainPageModel value) {
    _currentPos = value;
    notifyListeners();
  }

}
class LanguageNot with ChangeNotifier {
  String  _currentPos;

  LanguageNot(this._currentPos);

  String get sana => _currentPos;

  set sana(String value) {
    _currentPos = value;
    notifyListeners();
  }

}