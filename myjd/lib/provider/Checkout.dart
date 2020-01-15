import 'package:flutter/material.dart';

class Checkout with ChangeNotifier {
  List _checkOutList = [];

  List get chckoutList => this._checkOutList;

  double _totalPrice;

  double get totalPrice => this._totalPrice;

  changeCheckOutList(data) {
    this._checkOutList.clear();
    this.chckoutList.addAll(data);
    notifyListeners();
  }

  setTotalPrice(price) {
    this._totalPrice = price;
    notifyListeners();
  }
}
