import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import '../widet/JdInputText.dart';
import '../widet/JdButton.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          ),
          SizedBox(
            height: 20,
          ),
          JdInputText(
            text: '密码',
            password: true,
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
            cb: () {},
          )
        ],
      ),
    );
  }
}
