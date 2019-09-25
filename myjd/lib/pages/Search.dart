import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/service/SearchService.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keyword;

  //保存搜索历史记录
  List _historyListData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getHistoryData();
  }

  //此方法获取历史记录
  _getHistoryData() async {
    var _historyListData = await SearchService.getHistoryList();
    setState(() {
      this._historyListData = _historyListData;
    });
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        context: context,
        barrierDismissible: false, //点击框外是否消失
        builder: (context) {
          return AlertDialog(
            title: Text('提示信息'),
            content: Text('您确定要删除吗？'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancle');
                  },
                  child: Text('取消')),
              FlatButton(
                  onPressed: () async {
                    //这里最好异步
                    await SearchService.removeHistoryData(keywords);
                    this._getHistoryData();
                    Navigator.pop(context, 'Ok');
                  },
                  child: Text('确定'))
            ],
          );
        });

    print(result);
  }

  Widget _historyListWidget() {
    if (_historyListData.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '历史记录',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this._historyListData.map((value) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('$value'),
                    onLongPress: () {
                      this._showAlertDialog('$value');
                    },
                    onTap: () {
                      setState(() {
                        this._keyword = value;
                      });
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  SearchService.clearHistoryList();
                  this._getHistoryData();
                },
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.delete), Text('清空历史记录')],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none),
              ),
              onChanged: (value) {
                this._keyword = value;
              },
              controller: TextEditingController.fromValue(TextEditingValue(
                  text: '${this._keyword == null ? "" : this._keyword}',  //判断keyword是否为空
                  // 保持光标在最后

                  selection: TextSelection.fromPosition(TextPosition(
                      affinity: TextAffinity.downstream,
                      offset: '${this._keyword}'.length)))),
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
              onTap: () {
                SearchService.setHistoryData(this._keyword);
                Navigator.pushReplacementNamed(context, '/productlist',
                    arguments: {'keyword': this._keyword});
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
              _historyListWidget()
            ],
          ),
        ));
  }
}
