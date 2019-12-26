import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/config/config.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Widget checkOutItem() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          width: ScreenAdapter.width(160),
          child: Image.network(
//              Config.domain + (value['pic']).replaceAll('\\', '/'),
              'https://cdnfile.aixifan.com/static/umeditor/emotion/images/ac/33.gif',
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
                  '测试数据',
                  maxLines: 1,
                ),
                Text(
                  '测试数据',
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                ),
                Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '测试数据',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('x2'),
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
  Widget build(BuildContext context) {
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
                    ListTile(
                      leading: Icon(
                        Icons.add_location,
                      ),
                      title: Center(child: Text('请添加收货地址')),
                      trailing: Icon(Icons.navigate_next),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('张三  15211111111'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('北京市海淀区西二旗'),
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
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
                  children: <Widget>[
                    checkOutItem(),
                    Divider(),
                    checkOutItem(),
                  ],
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
                    Text('商品总金额：￥200'),
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
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Colors.black54, width: 1))),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '总价：￥140',
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
}
