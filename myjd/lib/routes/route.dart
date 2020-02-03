
import 'package:flutter/material.dart';
import 'package:myjd/pages/AddAdress.dart';
import 'package:myjd/pages/Login.dart';
import 'package:myjd/pages/ProductContent.dart';
import 'package:myjd/pages/Register/RegisterFirst.dart';
import 'package:myjd/pages/Register/RegisterSecond.dart';
import 'package:myjd/pages/Register/RegisterThird.dart';
import 'package:myjd/pages/Search.dart';
import 'package:myjd/pages/Checkout.dart';
import 'package:myjd/pages/address/address_edit.dart';
import 'package:myjd/pages/address/address_list.dart';
import 'package:myjd/pages/address/adress_add.dart';
import '../pages/tabs/Tab.dart';
import '../pages/ProductList.dart';
import 'package:myjd/pages/ShopCart.dart';

//配置路由
final routes = {
  '/': (context) => Tabs(),
  '/search': (context) => SearchPage(),
  '/login': (context) => LoginPage(),
  '/registerfirst': (context) => RegisterFirst(),
  '/registersecond': (context, {arguments}) => RegisterSecond(
        arguments: arguments,
      ),
  '/registerthird': (context, {arguments}) =>
      RegisterThird(arguments: arguments),
  '/productlist': (context, {arguments}) => ProductListPage(arguments),
  '/productContent': (context, {arguments}) =>
      ProductContent(arguments: arguments),
  '/shopcart': (context) => ShopCartPage(),
  '/checkout': (context) => CheckoutPage(),
  // '/search': (context) => SearchPage(),
  '/addadress': (context) => AddAddressPage(),

  '/addressadd': (context) => AddAdressPage(),
  '/addressedit': (context) => EditAddressPage(),
  '/addresslist': (context) => AddressListPage(),
};

//固定写法
// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
