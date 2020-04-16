import 'package:flutter/material.dart';
import 'package:myjd/widet/JdButton.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("去支付")),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: ListView(
              children: <Widget>[


                SizedBox(height: 20,),
                

                ListTile(
                  leading: Image.network(
                      'https://ss3.bdstatic.com/yrwDcj7w0QhBkMak8IuT_XF5ehU5bvGh7c50/logopic/a9936a369e82e0c6c42112674a5220e8_fullsize.jpg'),
                  title: Text('支付宝'),
                  trailing: Icon(Icons.check),
                ),
                Divider(),
                ListTile(
                  leading: Image.network(
                      'https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=295952033,3878422369&fm=74&app=80&f=JPEG&size=f121,121?sec=1880279984&t=dd0777bbdf4705ba4225acd76f7e910e'),
                  title: Text('微信支付'),
                  trailing: Icon(Icons.check),
                ),
                Divider(),

                JdButton(text: "去支付",color: Colors.red, cb: (){

                    

                },)
              ],
            ),
          )
        ],
      ),
    );
  }
}
