import 'package:flutter/material.dart';
import 'dart:convert';
import '../service/Storage.dart';

class Cart with ChangeNotifier {
  bool isCheckedAll = false;

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
    this.isCheckedAll = isCartCheckedAll();

    notifyListeners();
  }

  update() {
    this.init();
  }

  // 购物车+-操作

  changeItemCount() {
    Storage.setString('cartList', json.encode(_cartList));
    notifyListeners();
  }

  //全选反选

  checkAll(val) {
    for (var i = 0; i < this.cartList.length; i++) {
      this.cartList[i]['checked'] = val;
    }

    Storage.setString('cartList', json.encode(_cartList));
    isCheckedAll = val;
    notifyListeners();
  }

  //判断当前是否是全选状态
  isCartCheckedAll() {
    var state = !this.cartList.any((item) => item['checked'] == false);
    return state;
  }

  //监听每一项选中
  itemChanged() {
    this.isCheckedAll = isCartCheckedAll();
    Storage.setString('cartList',json.encode(this.cartList));
    notifyListeners();
  }

}
