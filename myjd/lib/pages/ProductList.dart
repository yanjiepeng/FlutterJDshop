import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/model/ProductModel.dart';
import 'package:myjd/widet/LoadingWidget.dart';
import '../common/ScreenAdapter.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage(this.arguments);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //list控制器
  ScrollController scrollController = ScrollController();

  //global key
  final GlobalKey<ScaffoldState> _scoffoldKey = new GlobalKey<ScaffoldState>();

  //分页
  int _page = 1;

  //每页多少条数据
  int _pageSize = 8;

  //数据
  List<ProductItemModel> _productList = [];

  //排序 价格升序 sort=price_1 价格降序 sort=price_-1  销量升序 sort=salecount_1 销量降序 sort=salecount_-1
  String _sort = '';

  //是否还有数据
  bool _hasMore = true;

  //解决重复请求的问题
  bool flag = true;

  @override
  void initState() {
    super.initState();

    _getProductListData();

    //监听listView滚动
    this.scrollController.addListener(() {
      // scrollController.position.pixels // 获取滚动条滚动高度

      // scrollController.position.maxScrollExtent //页面高高度

      //差20高度的时候刷新
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20) {
        if (this.flag && this._hasMore) {
          _getProductListData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
        key: this._scoffoldKey,
        appBar: AppBar(
          title: Text('商品列表'),
          actions: <Widget>[
            Text(''), //顶掉右侧抽屉自动生成的菜单
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Text('实现筛选功能'),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
              padding: EdgeInsets.all(10),
              child: _productListWidget(),
            ),
            _subTitleWidget()
          ],
        ));
  }

  //二级导航菜单
  Widget _subTitleWidget() {
    return Positioned(
      top: 0,
      child: Container(
          width: ScreenAdaper.width(750),
          height: ScreenAdaper.height(80),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Text(
                      '综合',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onTap: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Text('销量', textAlign: TextAlign.center),
                  ),
                  onTap: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Text('价格', textAlign: TextAlign.center),
                  ),
                  onTap: () {},
                ),
                flex: 1,
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(16), 0, ScreenAdaper.height(16)),
                    child: Text('筛选', textAlign: TextAlign.center),
                  ),
                  onTap: () {
                    //打开右边侧边栏
                    this._scoffoldKey.currentState.openEndDrawer();
                  },
                ),
                flex: 1,
              )
            ],
          )),
      width: ScreenAdaper.width(750),
      height: ScreenAdaper.height(80),
    );
  }

  //判断是否有更多数据加载
  Widget _showMore(int index) {
    if(this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text('');
    }else{
      return  (index == this._productList.length - 1)?Text('没有更多啦'): Text('');
    }

  }

  //商品详情列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        child: ListView.builder(
          controller: this.scrollController,
          itemCount: this._productList.length,
          itemBuilder: (BuildContext context, int index) {
            String picUrl = Config.domain +
                (this._productList[index].pic).replaceAll('\\', '/');

            return Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdaper.width(180),
                        height: ScreenAdaper.height(180),
                        child: Image.network(
                          picUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container(
                            width: ScreenAdaper.width(180),
                            height: ScreenAdaper.height(180),
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(this._productList[index].title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: ScreenAdaper.height(36),
                                      margin: EdgeInsets.only(right: 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),

                                      //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration 123
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromRGBO(230, 230, 230, 0.9),
                                      ),

                                      child: Text('4g'),
                                    ),
                                    Container(
                                      height: ScreenAdaper.height(36),
                                      margin: EdgeInsets.only(right: 10),
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            Color.fromRGBO(230, 230, 230, 0.9),
                                      ),
                                      child: Text("126"),
                                    ),
                                  ],
                                ),
                                Text(
                                  this._productList[index].price.toString(),
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                  Divider(height: 20),
                  _showMore(index)
                ],
              ),
            );
          },
        ),
      );
    } else {
      //加载中
      return LoadingWidget();
    }
  }

  //请求列表数据
  Future _getProductListData() async {
    setState(() {
      this.flag = false;
    });

    var api =
        '${Config.domain}api/plist?cid=${widget.arguments['cid']}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';

    print(api);

    var result = await Dio().get(api);

    var productList = new ProductModel.fromJson(result.data);
    print(productList.result.length);
    if (productList.result.length < this._pageSize) {
      setState(() {
        this._productList.addAll(productList.result);
        this._hasMore = false;
        this.flag = true;
      });
    } else {
      setState(() {
        this._productList.addAll(productList.result);
        this._page++;
        this.flag = true;
      });
    }
  }
}
