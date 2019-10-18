import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
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
  }

  /**
   * 改造数据格式
   */
  void _initAttr() {
    var attr = this._attr;

    print(_attr);

    for (var i = 0; i < attr.length; i++) {
      print(attr[i].list);

      for (var j = 0; j < attr[i].list.length; j++) {
        //在Attr里创建了checklist存储选中情况
        attr[i].checkList.add({"title": attr[i].list[j], "checked": false});
      }
    }

    print(attr[0].checkList);
  }

  //封装组建渲染商品选择属性

  _attrBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            //解决showModalBottomSheet点击消失
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
                          children: this._attr.map((attrItem) {
                            return Wrap(
                              children: <Widget>[
                                Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: ScreenAdapter.height(46)),
                                    child: Text(
                                      '${attrItem.cate}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  width: ScreenAdapter.width(100),
                                ),
                                Container(
                                  width: ScreenAdapter.width(610),
                                  child: Wrap(
                                    children: attrItem.checkList.map((value) {
                                      return Container(
                                        margin: EdgeInsets.all(10),
                                        child: Chip(
                                          label: Text('${value['title']}'),
                                          padding: EdgeInsets.all(10),
                                          backgroundColor: value['checked']
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            );
                          }).toList())
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
        });
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
          Container(
            margin: EdgeInsets.only(top: 10),
            height: ScreenAdapter.height(80),
            child: InkWell(
              onTap: () {
                _attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text("已选: ", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("115，黑色，XL，1件")
                ],
              ),
            ),
          ),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
