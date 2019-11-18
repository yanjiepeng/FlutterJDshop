import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/provider/Cart.dart';
import 'CartCounter.dart';
import '../../config/config.dart';

class CartItem extends StatefulWidget {
  Cart provider;

  CartItem(this.provider);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    var provider = widget.provider;
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
                          value: value['checked'],
                          onChanged: (val) {
                            setState(() {
                              value['checked'] = !value['checked'];
                            });
                            provider.itemChanged();
                          },
                          activeColor: Colors.pink,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        width: ScreenAdapter.width(160),
                        child: Image.network(
                            Config.domain +
                                (value['pic']).replaceAll('\\', '/'),
                            fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                value['title'],
                                maxLines: 1,
                              ),
                              Text(
                                value['selectAttr'],
                                style: TextStyle(fontSize: 12),
                                maxLines: 1,
                              ),
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value['price'].toString(),
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: CartCounter(value),
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
          : Center(
              child: Text('购物车空空的'),
            ),
    );
  }
}
