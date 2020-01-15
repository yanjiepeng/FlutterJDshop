import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/pages/cart/CartItem.dart';
import 'package:myjd/provider/Checkout.dart';
import 'package:myjd/service/CartService.dart';
import 'package:myjd/service/UserService.dart';
import 'package:provider/provider.dart';
import 'package:myjd/provider/Cart.dart';

class FirstCartPage extends StatefulWidget {
  @override
  _FirstCartPageState createState() => _FirstCartPageState();
}

class _FirstCartPageState extends State<FirstCartPage> {
  bool _isEdit = false;

  var res;
  Checkout checkOutProvider;

  @override
  void initState() {
    super.initState();
    res = eventBus.on<EditEvent>().listen((event) {
      print('eventbus222 ${event.flag}');

      setState(() {
        this._isEdit = event.flag;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    res?.cancel();
  }

  Future doCheckOut() async {
    //判断用户是否登录 保存购物车数据

    var checkoutData = await CartService.getCheckOutData();

    var totolPrice = await CartService.getTotalPrice();

    print(checkoutData);

    //保存购物车数据在provider
    this.checkOutProvider.changeCheckOutList(checkoutData);

    this.checkOutProvider.setTotalPrice(totolPrice);



    //判断购物车是否有数据

    if (checkoutData.length != 0) {
      //判断是否登录
      var isLogin = await UserService.getUserLoginState();

      if (isLogin) {
        Navigator.pushNamed(context, '/checkout');
      } else {
        Fluttertoast.showToast(
            msg: '您还没有登录，请先登录',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);

        Navigator.pushNamed(context, '/login');
      }
    } else {
      Fluttertoast.showToast(
          msg: '购物车没有选中的数据',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context);
    checkOutProvider = Provider.of<Checkout>(context);
    ScreenAdapter.init(context);

    return Scaffold(
//      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//      floatingActionButton: FloatingActionButton(
//
//        onPressed: () {
//        },
//        child: Icon(
//          Icons.add,
//          color: Colors.white,
//        ),
//        backgroundColor: Colors.red,
//      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(bottom: ScreenAdapter.height(78)),
            child: Column(
              children: <Widget>[CartItem(provider)],
            ),
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
                              value: provider.isCheckedAll,
                              onChanged: (value) {
                                //实现全选反选功能
                                provider.checkAll(value);
                              },
                              checkColor: Colors.pink,
                            ),
                          ),
                          Text('全选'),
                          SizedBox(
                            width: 20,
                          ),
                          !this._isEdit
                              ? Text(
                                  '总价${provider.totalPrice}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                )
                              : Text('')
                        ],
                      ),
                    ),
                    this._isEdit
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              child: Text(
                                '删除',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                provider.removeCartItem();
                              },
                              color: Colors.red,
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: RaisedButton(
                              child: Text(
                                '结算',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: doCheckOut,
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
