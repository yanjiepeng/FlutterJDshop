import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';

class RegisterSecond extends StatefulWidget {
  final Map arguments;

  RegisterSecond({this.arguments});

  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {
  String tel;
  bool sendCodeBtn = false;
  int seconds = 10;
  String code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.tel = widget.arguments['tel'];
    this._showTimer();
  }

  _showTimer() {
//    Timer t;
//    t = Timer.periodic(Duration(microseconds: 1000), (timer) {
//      setState(() {
//        this.seconds--;
//      });
//      if (seconds == 0) {
//        timer.cancel(); //清除定时器
//        setState(() {
//          this.sendCodeBtn = true;
//        });
//      }
//    });

    Timer t;
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        this.seconds--;
      });
      if (this.seconds == 0) {
        t.cancel(); //清除定时器
        setState(() {
          this.sendCodeBtn = true;
        });
      }
    });
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
            Container(
              child: Text('请输入${this.tel}手机收到的验证码'),
            ),
            SizedBox(
              height: 40,
            ),
            Stack(
              children: <Widget>[
                JdInputText(
                  text: '请输入验证码',
                  onChanged: (value) {
                    this.code = value;
                  },
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: sendCodeBtn
                      ? RaisedButton(
                    onPressed: () {
                      sendCode(this.tel);
                    },
                    child: Text('重新发送'),
                  )
                      : RaisedButton(
                    onPressed: () {},
                    child: Text('${this.seconds}秒后重新发送'),
                  ),
                )
              ],
            ),
            JdButton(
              color: Colors.red,
              text: '下一步',
              cb: this.validateCode,
            )
          ],
        ),
      ),
    );
  }

  /// 发送验证码
  sendCode(String tel) async {
    setState(() {
      this.sendCodeBtn = false;
      this.seconds = 10;
      this._showTimer();
    });
    var api = '${Config.domain}api/sendCode';
    var response = await Dio().post(api, data: {"tel": this.tel});
    if (response.data["success"]) {
      print(response); //演示期间服务器直接返回  给手机发送的验证码
    }
  }


  //验证验证码

  validateCode() async {

    var api = '${Config.domain}api/validateCode';
    var response = await Dio().post(api, data: {"tel": this.tel,"code": this.code});
    if (response.data["success"]) {
      Navigator.pushNamed(context, '/registerthird');
    }else{
      Fluttertoast.showToast(
        msg: '${response.data["message"]}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

  }

}
