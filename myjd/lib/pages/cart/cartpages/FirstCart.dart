import 'package:flutter/material.dart';
import 'package:myjd/pages/cart/CartItem.dart';
import 'package:myjd/pages/cart/CartNum.dart';
import 'package:provider/provider.dart';
import 'package:myjd/provider/Cart.dart';

class FirstCartPage extends StatefulWidget {
  @override
  _FirstCartPageState createState() => _FirstCartPageState();
}

class _FirstCartPageState extends State<FirstCartPage> {
  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addList('测试商品');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: <Widget>[

          CartItem(),
          Divider(height: 40,),
          CartNumber(),
        ],
      ),

    );
  }
}
