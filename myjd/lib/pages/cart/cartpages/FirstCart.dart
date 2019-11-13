import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/pages/cart/CartItem.dart';
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
    ScreenAdapter.init(context);
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
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[CartItem()],
          ),
          Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(78),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(width: 1, color: Colors.black12))),
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.height(78),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(60),
                            child: Checkbox(
                              value: true,
                              onChanged: (value) {},
                              checkColor: Colors.pink,
                            ),
                          ),
                          Text('全选')
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        child: Text(
                          '结算',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),

      /*    Column(
        children: <Widget>[
          CartItem(),
          Divider(height: 40,),
          CartNumber(),
        ],
      ),*/
    );
  }
}
