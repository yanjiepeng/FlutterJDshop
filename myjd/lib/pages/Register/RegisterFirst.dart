import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdInputText.dart';
import '../../widet/JdButton.dart';
import '../../widet/JdInputText.dart';
import 'package:dio/dio.dart';
import 'package:myjd/config/config.dart';

class RegisterFirst extends StatefulWidget {
  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
  String tel = '';

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
              text: '请输入手机号',
              onChanged: (value) {
                this.tel = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            JdButton(
              color: Colors.red,
              text: '下一步',
              cb: () {
                sendCode(this.tel);
              },
            )
          ],
        ),
      ),
    );
  }

  /// 发送验证码
  sendCode(String tel) async {
    //验证手机号
    RegExp reg = new RegExp(r"^1\d{10}$");
    if (reg.hasMatch(tel)) {
      var api = '${Config.domain}api/sendcode';
      var response = await Dio().post(api, data: {'tel': tel});

      if (response.data['success']) {
        //成功跳转到下一页
        print(response.data);
        Navigator.pushNamed(context, '/registersecond',
            arguments: {'tel': tel});
      } else {
        Fluttertoast.showToast(
            msg: response.data['message'],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(
          msg: '手机号格式错误',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
  }
}
