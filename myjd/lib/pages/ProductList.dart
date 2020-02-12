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

  //是否有搜索的数据
  bool _hasData = true;

  /*二级导航数据*/
  List _subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  //二級菜單選中
  int _selectSubtitle = 1;

  //搜索框的值
  var _initKeywordController = new TextEditingController();

  //keyword
  var _cid;

  var _keyword;

  @override
  void initState() {
    super.initState();

    this._cid = widget.arguments['cid'];
    this._keyword = widget.arguments['keyword'];
    //给search框赋值为keyword

    this._initKeywordController.text = this._keyword;

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
    ScreenAdapter.init(context);

    return Scaffold(
        key: this._scoffoldKey,
        appBar: AppBar(
          title: Container(
            child: TextField(
              controller: this._initKeywordController,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                setState(() {
                  this._keyword = value;
                });
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
              onTap: () {
                //点击搜索
                _subTitleChanged(1);
              },
            )
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            child: Center(
              child: Text('筛选功能'),
            ),
          ),
        ),
        body: _hasData
            ? Stack(
                children: <Widget>[_productListWidget(), _subTitleWidget()],
              )
            : Center(
                child: Text('没有您要浏览的数据'),
              ));
  }

  _subTitleChanged(_id) {
    if (_id == 4) {
      this._scoffoldKey.currentState.openEndDrawer();
      setState(() {
        this._selectSubtitle = _id;
      });
    } else {
      setState(() {
        this._selectSubtitle = _id;
        this._sort =
            "${this._subHeaderList[_id - 1]["fileds"]}_${this._subHeaderList[_id - 1]["sort"]}";
        //重置數據
        this._page = 1;
        this._productList = [];
        //改变sort排序
        this._subHeaderList[_id - 1]['sort'] =
            this._subHeaderList[_id - 1]['sort'] * -1;
        //listView回到顶部
        this.scrollController.jumpTo(0);
        //重置_hasMore
        this._hasMore = true;
        //重新请求
        this._getProductListData();
      });
    }
  }

  //显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (this._subHeaderList[id - 1]["sort"] == 1) {
        return Icon(Icons.arrow_drop_down);
      }
      return Icon(Icons.arrow_drop_up);
    }
    return Text("");
  }

  //二级导航菜单
  Widget _subTitleWidget() {
    return Positioned(
      top: 0,
      child: Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(80),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: this._subHeaderList.map((value) {
              return Expanded(
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          value['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: (this._selectSubtitle == value['id']
                                  ? Colors.red
                                  : Colors.black54)),
                        ),
                        _showIcon(value['id'])
                      ],
                    ),
                  ),
                  onTap: () => _subTitleChanged(value['id']),
                ),
                flex: 1,
              );
            }).toList(),
          )),
      width: ScreenAdapter.width(750),
      height: ScreenAdapter.height(80),
    );
  }

  //判断是否有更多数据加载
  Widget _showMore(int index) {
    if (this._hasMore) {
      return (index == this._productList.length - 1)
          ? LoadingWidget()
          : Text('');
    } else {
      return (index == this._productList.length - 1) ? Text('没有更多啦') : Text('');
    }
  }

  //商品详情列表
  Widget _productListWidget() {
    if (this._productList.length > 0) {
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: this.scrollController,
          itemCount: this._productList.length,
          itemBuilder: (BuildContext context, int index) {
            String picUrl = Config.domain +
                (this._productList[index].pic).replaceAll('\\', '/');

            return GestureDetector(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(180),
                            height: ScreenAdapter.height(180),
                            child: Image.network(
                              picUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: ScreenAdapter.width(180),
                                height: ScreenAdapter.height(180),
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(this._productList[index].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: ScreenAdapter.height(36),
                                          margin: EdgeInsets.only(right: 10),
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),

                                          //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                230, 230, 230, 0.9),
                                          ),

                                          child: Text('4g'),
                                        ),
                                        Container(
                                          height: ScreenAdapter.height(36),
                                          margin: EdgeInsets.only(right: 10),
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color.fromRGBO(
                                                230, 230, 230, 0.9),
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
                ),
                //listview点击事件
                onTap: () => Navigator.pushNamed(context, '/productContent' , arguments: {'id':this._productList[index].sId}));
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

    var api;
    if (this._keyword == null) {
      api =
          '${Config.domain}api/plist?cid=${widget.arguments['cid']}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    } else {
      api =
          '${Config.domain}api/plist?search=${this._keyword}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';
    }

    print(api);

    var result = await Dio().get(api);

    var productList = new ProductModel.fromJson(result.data);

    if (productList.result.length == 0 && this._page == 1) {
      setState(() {
        this._hasData = false;
      });
    } else {
      setState(() {
        this._hasData = true;
      });
    }
    //判断最后一页有没有数据
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
