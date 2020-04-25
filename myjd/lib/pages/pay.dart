import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:myjd/widet/JdButton.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "checked": true,
      "image":
          'https://ss3.bdstatic.com/yrwDcj7w0QhBkMak8IuT_XF5ehU5bvGh7c50/logopic/a9936a369e82e0c6c42112674a5220e8_fullsize.jpg',
    },
    {
      "title": "微信支付",
      "checked": false,
      "image":
          'https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=295952033,3878422369&fm=74&app=80&f=JPEG&size=f121,121?sec=1880279984&t=dd0777bbdf4705ba4225acd76f7e910e',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("去支付")),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: payList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
                          child: ListTile(
                            leading: Image.network(payList[index]['image']),
                            title: Text('${payList[index]['title']}'),
                            trailing: payList[index]['checked']
                                ? Icon(Icons.check)
                                : Text(''),
                            onTap: () {
                              setState(() {
                                for (var i = 0; i < payList.length; i++) {
                                  payList[i]['checked'] = false;
                                }
                                payList[index]['checked'] = true;
                              });
                            },
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
                SizedBox(height:20),
                JdButton(
                  color: Colors.red,
                  text: '去支付',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
