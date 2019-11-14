import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/widet/LoadingWidget.dart';

import 'ProductContent/ProductContentFirst.dart';
import 'ProductContent/ProductContentSecond.dart';
import 'ProductContent/ProductContentThird.dart';
import 'package:myjd/widet/JdButton.dart';

import 'package:dio/dio.dart';
import 'package:myjd/model/ProductContentModel.dart';
import 'package:myjd/config/config.dart';

class ProductContent extends StatefulWidget {
  final Map arguments;

  ProductContent({Key key, this.arguments}) : super(key: key);

  @override
  _ProductContentState createState() => _ProductContentState();
}

class _ProductContentState extends State<ProductContent> {
  List _productContentList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._getContentData();
  }

  _getContentData() async {
    var api = '${Config.domain}api/pcontent?id=${widget.arguments['id']}';
    var result = await Dio().get(api);
    var productContent = new ProductContentModel.fromJson(result.data);
    print(productContent.item.sId);
    setState(() {
      _productContentList.clear();
      this._productContentList.add(productContent.item);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(400),
                  child: TabBar(
                    indicatorColor: Colors.red,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        child: Text('商品'),
                      ),
                      Tab(
                        child: Text('详情'),
                      ),
                      Tab(
                        child: Text('评价'),
                      )
                    ],
                  ),
                )
              ],
            ),
            actions: <Widget>[
              //更多按钮
              IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(
                            ScreenAdapter.width(600), 76, 10, 0),
                        items: [
                          PopupMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.home),
                                  Text('首页')
                                ],
                              )),
                          PopupMenuItem(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.search),
                                  Text('搜索')
                                ],
                              ))
                        ]);
                  })
            ],
          ),
          body: this._productContentList.length > 0
              ? Stack(
            children: <Widget>[
              TabBarView(
                children: <Widget>[
                  ProductContentFirst(this._productContentList),
                  ProductContentSecond(this._productContentList),
                  ProductContentThird()
                ],
              ),
              Positioned(
                width: ScreenAdapter.width(750),
                height: ScreenAdapter.width(80),
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black26, width: 1)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdapter.height(10)),
                        width: 100,
                        height: ScreenAdapter.height(88),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.shopping_cart),
                            Text("购物车")
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: JdButton(
                            color: Color.fromRGBO(253, 1, 0, 0.9),
                            text: '加入购物车',
                            cb: () {
                              if ((this._productContentList[0] as ProductContentItem).attr.length > 0) {
                                eventBus.fire(new CartEvent(
                                    '加入购物车${this._productContentList[0].sId}'));
                              } else {
                                print('else 加入购物车');
                              }
                            }),
                      ),
                      Expanded(
                        flex: 1,
                        child: JdButton(
                            color: Color.fromRGBO(255, 165, 0, 0.9),
                            text: '立即购买',
                            cb: () {

                              if((this._productContentList[0] as ProductContentItem).attr.length > 0) {
                                eventBus.fire(new CartEvent(
                                    '立即购买${this._productContentList[0].sId}'));
                              }else{
                                print('else 立即购买');

                              }
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
              : LoadingWidget(),
        ));
  }
}
