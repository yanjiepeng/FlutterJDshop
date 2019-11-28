import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/widet/JdInputText.dart';

class RegisterThird extends StatefulWidget {
  @override
  _RegisterThirdState createState() => _RegisterThirdState();
}

class _RegisterThirdState extends State<RegisterThird> {
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
            SizedBox(height: 30,),
            JdInputText(text: '请输入密码',),
            SizedBox(height: 20,),
            JdInputText(text: '请再次输入密码',),
            SizedBox(height: 20,),
            JdButton(
              color: Colors.red,
              text: '完成',
              cb: () {
//                Navigator.pushNamed(context,'/registersecond' );
              },
            )
          ],

        ),
      ),
    );

  }
}
