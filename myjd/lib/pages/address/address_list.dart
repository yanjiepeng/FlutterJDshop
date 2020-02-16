import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/service/SignService.dart';
import 'package:myjd/service/UserService.dart';

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List _addressList = [];

  _getAddressList() async {
    var userInfo = await UserService.getUserInfo();

    var tempJson = {"uid": userInfo[0]['_id'], "salt": userInfo[0]['salt']};

    String sign = SignService.getSign(tempJson);

    var api =
        '${Config.domain}api/addressList?uid=${userInfo[0]['_id']}&sign=$sign';

    var response = await Dio().get(api);

    setState(() {
      this._addressList = response.data['result'];
    });

    print(response);
  }

  //修改默认收货地址
  _modifyDefalutAddress(id) async {
    List userinfo = await UserService.getUserInfo();

    var tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]["salt"]
    };

    var sign = SignService.getSign(tempJson);

    var api = '${Config.domain}api/changeDefaultAddress';
    var response = await Dio()
        .post(api, data: {"uid": userinfo[0]['_id'], "id": id, "sign": sign});
    Navigator.pop(context);
    eventBus.fire(DefaultAddressEvent(''));
  }

  @override
  void initState() {
    super.initState();
    this._getAddressList();

    eventBus.on<AddressEvent>().listen((event) {
      this._getAddressList();
    });
  }

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
            ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ListTile(
                      leading: this._addressList[index]['default_address'] == 1
                          ? Icon(Icons.check, color: Colors.red)
                          : Text(''),
                      title: InkWell(
                        onTap: () {
                          _modifyDefalutAddress(this._addressList[index]['_id']);
                        },
                        child: Text(
                            '${this._addressList[index]['name']}      ${this._addressList[index]['phone']}'),
                      ),
                      subtitle: Text('${this._addressList[index]['address']}'),
                      trailing: Icon(Icons.edit, color: Colors.blue),
                    ),
                    Divider(height: 20)
                  ],
                );
              },
              itemCount: this._addressList.length,
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
