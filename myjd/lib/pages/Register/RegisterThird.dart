import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/pages/tabs/Tab.dart';
import 'package:myjd/service/Storage.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:myjd/config/config.dart';

// ignore: must_be_immutable
class RegisterThird extends StatefulWidget {
  Map arguments;

  RegisterThird({this.arguments});

  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
  String tel;
  String password;
  String rePassword;
  String code;

  @override
  void initState() {
    super.initState();

    this.tel = widget.arguments['tel'];
    this.code = widget.arguments['code'];
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            JdInputText(
              text: '请输入密码',
              password: true,
              onChanged: (value) {
                this.password = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            JdInputText(
              text: '请再次输入密码',
              onChanged: (value) {
                this.rePassword = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            JdButton(
              color: Colors.red,
              text: '完成',
              cb: doRegister,
            )
          ],
        ),
      ),
    );
  }

  doRegister() async {
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: '密码长度不能小于6位',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (rePassword != password) {
      Fluttertoast.showToast(
        msg: '密码和确认密码不一致',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      var api = '${Config.domain}api/register';

      var response = await Dio().post(api, data: {
        'tel': this.tel,
        'code': this.code,
        'password': this.password
      });

      if (response.data['success']) {
        //保存用户信息返回到跟
        Storage.setString('userinfo', json.encode(response.data['userinfo']));

        //返回到根
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new Tabs()),
                (route) => route == null);
      } else {
        //
        Fluttertoast.showToast(
          msg: '${response.data["message"]}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }
}
