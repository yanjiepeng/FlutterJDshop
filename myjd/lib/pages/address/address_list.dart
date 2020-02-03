import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  title: Text('张三 123455666'),
                  subtitle: Text('北京市海淀区西二旗'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  title: Text('张三 123455666'),
                  subtitle: Text('北京市海淀区西二旗'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  title: Text('张三 123455666'),
                  subtitle: Text('北京市海淀区西二旗'),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
              ],
            ),
            Positioned(
              child: Container(
                  height: 50,
                  width: ScreenAdapter.width(750),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.black26))),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/addressadd');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add, color: Colors.white),
                        Text(
                          '新增收货地址',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )),
              bottom: 0,
            )
          ],
        ),
      ),
    );
  }
}
