import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/service/Storage.dart';
import '../widet/JdInputText.dart';
import '../widet/JdButton.dart';
import 'package:myjd/config/config.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userName = '';
  String password = '';

  @override
  void dispose() {
    super.dispose();
    eventBus.fire(UserEvent('登录成功'));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[FlatButton(onPressed: () {}, child: Text('客服'))],
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: ScreenAdapter.width(160),
              height: ScreenAdapter.height(160),
              child: Image.asset('assets/jd_logo.png'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          JdInputText(
            text: "账户",
            onChanged: (value) {
              this.userName = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
          JdInputText(
            text: '密码',
            password: true,
            onChanged: (value) {
              this.password = value;
            },
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Stack(
              children: <Widget>[
                Align(
                  child: Text(
                    '忘记密码',
                    style: TextStyle(color: Colors.grey),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Align(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registerfirst');
                      },
                      child: Text(
                        '新用户注册',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    alignment: Alignment.centerRight)
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          JdButton(
            color: Colors.red,
            text: '登录',
            cb: doLogin,
          )
        ],
      ),
    );
  }

  doLogin() async {
    RegExp regExp = RegExp(r"^1\d{10}$");

    //用户名只能输入手机号
    if (!regExp.hasMatch(this.userName)) {
      Fluttertoast.showToast(
          msg: '手机号格式不对',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else if (this.password.length < 6) {
      Fluttertoast.showToast(
          msg: '密码少于6位',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER);
    } else {
      var api = '${Config.domain}api/doLogin';
      var response = await Dio().post(api,
          data: {'username': this.userName, 'password': this.password});
      if (response.data['success']) {
        //保存信息
        print(response.data);
        Storage.setString('userInfo', json.encode(response.data['userinfo']));
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: '${response.data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER);
      }
    }
  }
}
