import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  var _keyword;

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                this._keyword = value;
              },
            ),
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
          ),
          actions: <Widget>[
            InkWell(
              child: Container(
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.width(80),
                child: Row(
                  children: <Widget>[Text('搜索')],
                ),
              ),
              onTap: (){
                Navigator.pushReplacementNamed(context , '/productlist', arguments: {
                  'keyword':this._keyword
                });
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  '热搜',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Divider(),
              Wrap(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('笔记本电脑'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('女装'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('男装'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('测试'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('手机'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('男装'),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  '历史记录',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              Divider(),
              Column(
                children: <Widget>[
                  ListTile(
                    title: Text("女装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("女装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("男装"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("手机"),
                  ),
                  Divider(),
                  ListTile(
                    title: Text("鞋子"),
                  ),
                  Divider(),
                ],
              ),
              SizedBox(height: 100),
              InkWell(
                onTap: () {},
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text("清空历史记录")],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
