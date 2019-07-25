import 'package:flutter/material.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCarteState createState() => _ShopCarteState();
}

class _ShopCarteState extends State<ShopCartPage> with AutomaticKeepAliveClientMixin{

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => Text('购物车');

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  

}