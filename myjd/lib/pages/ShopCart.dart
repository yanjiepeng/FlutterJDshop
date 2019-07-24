import 'package:flutter/material.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCarteState createState() => _ShopCarteState();
}

class _ShopCarteState extends State<ShopCartPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Text('购物车');
  }

  @override
  bool get wantKeepAlive => true;
}