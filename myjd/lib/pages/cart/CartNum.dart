import 'package:flutter/material.dart';
import 'package:myjd/provider/Cart.dart';
import 'package:provider/provider.dart';

class CartNumber extends StatefulWidget {
  @override
  _CartNumberState createState() => _CartNumberState();
}

class _CartNumberState extends State<CartNumber> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context);

    return Column(
      children: <Widget>[Text('总数量：${provider.cartNum}')],
    );
  }
}
