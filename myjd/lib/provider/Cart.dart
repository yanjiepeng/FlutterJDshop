import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List _cartList = [];
  int _cartNum = 0;

  addList(value) {
    _cartList.add(value);
    notifyListeners();
  }

  int get cartNum => this._cartList.length;

  List get cartList => this._cartList;
}
