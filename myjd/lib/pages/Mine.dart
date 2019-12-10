import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/service/UserService.dart';
import 'package:myjd/widet/JdButton.dart';

class MinePage extends StatefulWidget {
  @override
  _MineeState createState() => _MineeState();
}

class _MineeState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  bool isLogin = false;

  List userInfo = [];

  @override
  void initState() {
    super.initState();
    _getUserInfo();

    //监听登录广播
    eventBus.on<UserEvent>().listen((event) {
      _getUserInfo();
    });
  }

  _getUserInfo() async {
    var isLogin = await UserService.getUserLoginState();
    List user = await UserService.getUserInfo();

    setState(() {
      this.userInfo = user;
      this.isLogin = isLogin;
    });
  }

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
                this.isLogin
                    ? Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("用户名：${this.userInfo[0]["username"]}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(32))),
                            Text("普通会员",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdapter.size(24))),
                          ],
                        ),
                      )
                    : Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            '登录/注册',
                            style: TextStyle(color: Colors.white),
                          ),
                        ))
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
          Divider(),
          this.isLogin
              ? Container(
                  padding: EdgeInsets.all(20),
                  child: JdButton(
                    color: Colors.red,
                    text: "退出登录",
                    cb: () {
                      UserService.loginOut();
                      this._getUserInfo();
                    },
                  ),
                )
              : Text("")
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
