import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';

class RegisterSecond extends StatefulWidget {
  @override
  _RegisterSecondState createState() => _RegisterSecondState();
}

class _RegisterSecondState extends State<RegisterSecond> {

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
              child: Text('请输入xxxx手机收到的验证码'),
            ),

            SizedBox(height: 40,),
            Stack(
              children: <Widget>[
                JdInputText(text: '请输入验证码',),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: RaisedButton(onPressed: () {},
                      child: Text('发送验证码'),
                  ),
                )
              ],
            ),
            JdButton(
              color: Colors.red,
              text: '下一步',
              cb: () {
                Navigator.pushNamed(context,'/registerthird' );
              },
            )

          ],

        ),

      ),
    );
  }
}
