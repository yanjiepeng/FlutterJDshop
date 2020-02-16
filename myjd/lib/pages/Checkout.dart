import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/provider/Checkout.dart';
import 'package:myjd/service/SignService.dart';
import 'package:myjd/service/UserService.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:myjd/config/config.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isLogin;
  List _defalutAddressList = [];

  Widget checkOutItem(item) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          width: ScreenAdapter.width(160),
          child: Image.network(
//              Config.domain + (value['pic']).replaceAll('\\', '/'),
              Config.domain + (item['pic']).replaceAll('\\', '/'),
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
                  item['title'],
                  maxLines: 1,
                ),
                Text(
                  item['selectAttr'],
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item['price'].toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(item['count'].toString()),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
//    getUserLoginState();

    _getDefaultAddress();

    eventBus.on<DefaultAddressEvent>().listen((data) {
      _getDefaultAddress();
    });
  }

  //获取默认收货地址
  _getDefaultAddress() async {
    List userinfo = await UserService.getUserInfo();

    // print('1234');
    var tempJson = {"uid": userinfo[0]["_id"], "salt": userinfo[0]["salt"]};

    var sign = SignService.getSign(tempJson);

    var api =
        '${Config.domain}api/oneAddressList?uid=${userinfo[0]["_id"]}&sign=${sign}';
    var response = await Dio().get(api);

    print(response);

    setState(() {
      this._defalutAddressList = response.data['result'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var checkoutProvider = Provider.of<Checkout>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('结算'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              //地址
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    this._defalutAddressList.length > 0
                        ? ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/addresslist');
                            },
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    '${this._defalutAddressList[0]['name']}    ${this._defalutAddressList[0]['phone']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    '${this._defalutAddressList[0]['address']}'),
                              ],
                            ),
                            trailing: Icon(Icons.navigate_next),
                          )
                        : ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/addressadd');
                            },
                            leading: Icon(
                              Icons.add_location,
                            ),
                            title: Center(child: Text('请添加收货地址')),
                            trailing: Icon(Icons.navigate_next),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(12)),
                child: Column(
                  children: checkoutProvider.chckoutList.map((item) {
                    return Column(
                      children: <Widget>[checkOutItem(item), Divider()],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                padding: EdgeInsets.all(ScreenAdapter.width(12)),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('商品总金额：${checkoutProvider.totalPrice.toString()}'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('立减：￥50'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('运费：￥0'),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              width: ScreenAdapter.width(750),
              height: ScreenAdapter.height(100),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 1))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${checkoutProvider.totalPrice - 50.0}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RaisedButton(
                        onPressed: () {},
                        child: Text(
                          '立即下单',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  getUserLoginState() async {
    bool isLogin = await UserService.getUserLoginState();

    setState(() {
      this.isLogin = isLogin;
    });
  }
}
