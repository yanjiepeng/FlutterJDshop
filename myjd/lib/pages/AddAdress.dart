import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String area = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('添加收货地址'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 12),
        child: ListView(
          children: <Widget>[
            JdInputText(
              text: '收货人姓名',
              password: false,
            ),
            SizedBox(
              height: 10,
            ),
            JdInputText(
              text: '收货人电话',
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: ScreenAdapter.height(68),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12))),
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area.length > 0
                        ? Text(
                            this.area,
                            style: TextStyle(color: Colors.black54),
                          )
                        : Text(
                            '省市区',
                            style: TextStyle(color: Colors.black54),
                          )
                  ],
                ),
                onTap: () {
                  //弹出选择对话框
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            JdInputText(
              text: '详细地址',
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              child: Text('弹出省市区'),
              onPressed: () {},
            ),
            SizedBox(
              height: 40,
            ),
            JdButton(
              text: '增加',
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
