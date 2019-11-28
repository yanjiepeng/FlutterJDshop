import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/widet/JdInputText.dart';
import '../../widet/JdButton.dart';
import '../../widet/JdInputText.dart';


class RegisterFirst extends StatefulWidget {
  @override
  _RegisterFirstState createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
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
            JdInputText(text: '请输入手机号',),
            SizedBox(height: 20,),
            JdButton(
              color: Colors.red,
              text: '下一步',
              cb: () {

                Navigator.pushNamed(context,'/registersecond' );
              },
            )
          ],

        ),
      ),
    );
  }
}
