import 'package:flutter/material.dart';
import 'package:myjd/provider/Cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context);
    return Expanded(
      child: provider.cartNum > 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: provider.cartList.length,
              itemBuilder: (context, index) {
                var value = provider.cartList[index];
                return ListTile(
                  title: Text('$value'),
                  leading: Icon(Icons.print),
                );
              })
          : Text(''),
    );
  }
}
