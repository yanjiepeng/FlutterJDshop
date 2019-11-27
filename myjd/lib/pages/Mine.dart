import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';

class MinePage extends StatefulWidget {
  @override
  _MineeState createState() => _MineeState();
}

class _MineeState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: ScreenAdapter.height(220),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/user_bg.jpg"),
                    fit: BoxFit.cover)),
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ClipOval(
                    child: Image.asset(
                      "assets/user.png",
                      fit: BoxFit.cover,
                      width: ScreenAdapter.width(100),
                      height: ScreenAdapter.height(100),
                    ),
                  ),
                ),
                Expanded(flex: 1, child: Text('登录/注册',style: TextStyle(
                  color: Colors.white
                ),))
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.red,
            ),
            title: Text('订单列表'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.library_books,
              color: Colors.lightBlueAccent,
            ),
            title: Text('已付款'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.clear_all,
              color: Colors.red,
            ),
            title: Text('待付款'),
          ),
          Container(
            height: 20,
            width: double.infinity,
            color: Color.fromRGBO(242, 242, 242, 0.9),
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.lightBlueAccent,
            ),
            title: Text('我的收藏'),
          ),
          Divider(
            height: 1,
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.red,
            ),
            title: Text('在线客服'),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
