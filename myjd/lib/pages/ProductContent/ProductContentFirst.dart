
import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/model/ProductContentModel.dart';
import 'package:myjd/widet/JdButton.dart';
import 'package:myjd/config/config.dart';

class ProductContentFirst extends StatefulWidget {
  final List _productContentList;

  ProductContentFirst(this._productContentList);

  @override
  _ProductContentFirstState createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst>
    with AutomaticKeepAliveClientMixin {
  ProductContentItem _productContent;

  List<Attr> _attr = [];
  String _selectedValue;

  bool get wantKeepAlive => true;

  var  actionEventBus ;

  @override
  void initState() {
    super.initState();
    this._productContent = widget._productContentList[0];
    this._attr = this._productContent.attr;

    /**
     * 组装类似 数据
     * [{"title":"细带", "checked": true},{"title"："白色",checked:"true"}
     * 类似数据
     */

    _initAttr();

    //EventBus监听

    this.actionEventBus = eventBus.on<CartEvent>().listen((event) {

      print(event.msg);
      this._attrBottomSheet();
    });
  }


  @override
  void dispose() {
    super.dispose();
    this.actionEventBus.cancel();

  }

  


//  改造数据格式
  void _initAttr() {
    var attr = this._attr;

    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].checkList.add({"title": attr[i].list[j], "checked": true});
        } else {
          attr[i].checkList.add({"title": attr[i].list[j], "checked": false});
        }
      }
    }
    _getSelectedAttrValue();
  }

  void _changeAtter(cate, title, setBottomState) {
    List<Attr> attr = this._attr;
    for (var i = 0; i < attr.length; i++) {
      if (attr[i].cate == cate) {
        for (var j = 0; j < attr[i].list.length; j++) {
          attr[i].checkList[j]["checked"] = false;
          if (title == attr[i].checkList[j]['title']) {
            attr[i].checkList[j]['checked'] = true;
          }
        }
      }
    }

    setBottomState(() {
      this._attr = attr;
    });

    _getSelectedAttrValue();
  }

  //获取选中的值
  _getSelectedAttrValue() {
    var _list = this._attr;
    List tempArr = [];
    for (var i = 0; i < _list.length; i++) {
      for (var j = 0; j < _list[i].checkList.length; j++) {
        if (_list[i].checkList[j]['checked'] == true) {
          tempArr.add(_list[i].checkList[j]["title"]);
        }
      }
    }
    // print(tempArr.join(','));
    setState(() {
      this._selectedValue = tempArr.join(',');
    });
  }

  //封装组建渲染商品选择属性

  //循环具体属性
  List<Widget> _getAttrItemWidget(attrItem, setBottomState) {
    List<Widget> attrItemList = [];
    attrItem.checkList.forEach((item) {
      attrItemList.add(Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            _changeAtter(attrItem.cate, item["title"], setBottomState);
          },
          child: Chip(
            label: Text("${item["title"]}"),
            padding: EdgeInsets.all(10),
            backgroundColor: item["checked"] ? Colors.red : Colors.black26,
          ),
        ),
      ));
    });
    return attrItemList;
  }

  //封装一个组件 渲染attr
  List<Widget> _getAttrWidget(setBottomState) {
    List<Widget> attrList = [];
    this._attr.forEach((attrItem) {
      attrList.add(Wrap(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(120),
            child: Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(22)),
              child: Text("${attrItem.cate}: ",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: ScreenAdapter.width(590),
            child: Wrap(
              children: _getAttrItemWidget(attrItem, setBottomState),
            ),
          )
        ],
      ));
    });

    return attrList;
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    String pic = Config.domain + this._productContent.pic;
    pic = pic.replaceAll('\\', '/');

    return Container(
        child: Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 12,
            child: Image.network(
              '$pic',
              fit: BoxFit.cover,
            ),
          ),
          //标题
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              '${this._productContent.title}',
              style: TextStyle(
                  color: Colors.black87, fontSize: ScreenAdapter.size(36)),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                '${this._productContent.subTitle}',
                style: TextStyle(
                    color: Colors.black54, fontSize: ScreenAdapter.size(28)),
              )),
          //价格
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text("特价: "),
                      Text('${this._productContent.price}',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenAdapter.size(46))),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("原价: "),
                      Text('${this._productContent.oldPrice}',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: ScreenAdapter.size(28),
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
          //筛选
          this._attr.length > 0
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  height: ScreenAdapter.height(80),
                  child: InkWell(
                    onTap: () {
                      _attrBottomSheet();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("已选: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            "${this._selectedValue == null ? "未选中" : this._selectedValue}")
                      ],
                    ),
                  ),
                )
              : Text(''),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text("运费: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("免运费")
              ],
            ),
          ),
          Divider(),
        ],
      ),
    ));
  }

  //底部弹出框
  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, setBottomState) {
              return GestureDetector(
                //解决showModalBottomSheet点击消失的问题
                onTap: () {
                  return false;
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(ScreenAdapter.width(20)),
                      child: ListView(
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: _getAttrWidget(setBottomState))
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      width: ScreenAdapter.width(750),
                      height: ScreenAdapter.height(76),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: JdButton(
                                color: Color.fromRGBO(253, 1, 0, 0.9),
                                text: "加入购物车",
                                cb: () {
                                  print('加入购物车');
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: JdButton(
                                  color: Color.fromRGBO(255, 165, 0, 0.9),
                                  text: "立即购买",
                                  cb: () {
                                    print('立即购买');
                                  },
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }
}
