import 'package:flutter/material.dart';


class MainPageProv with ChangeNotifier {
  int _currentPos;

  MainPageProv(this._currentPos);

  int get sana => _currentPos;

  set sana(int value) {
    _currentPos = value;
    notifyListeners();
  }


}
