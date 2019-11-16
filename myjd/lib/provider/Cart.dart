import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/Storage.dart';

class Cart with ChangeNotifier {
  List _cartList = [];

  List get cartList => this._cartList;

  get cartNum => cartList.length;

  set cartList(List value) {
    _cartList = value;
  }

  Cart() {
    this.init();
  }

  init() async {
    try {
      List cartData = json.decode(await Storage.getString('cartList'));

      this.cartList = cartData;
    } catch (e) {
      this.cartList = [];
    }

    notifyListeners();
  }

  update(){
    this.init();
  }


}
