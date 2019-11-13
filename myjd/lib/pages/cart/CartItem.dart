import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/provider/Cart.dart';
import 'package:provider/provider.dart';
import 'CartCounter.dart';

class CartItem extends StatefulWidget {
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var provider = Provider.of<Cart>(context);
    return Expanded(
      child: provider.cartNum > 0
          ? ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: provider.cartList.length,
              itemBuilder: (context, index) {
                var value = provider.cartList[index];
                return Container(
                  height: ScreenAdapter.height(160),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1, color: Colors.lightBlueAccent))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(60),
                        child: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: Colors.pink,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: ScreenAdapter.width(160),
                        child: Image.network(
                            'https://www.itying.com/images/flutter/list2.jpg',
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '保温杯（350ml)',
                                maxLines: 2,
                              ),
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      r'$12',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CartCounter(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              })
          : Text(''),
    );
  }
}
