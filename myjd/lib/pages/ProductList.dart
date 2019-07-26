import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/model/ProductModel.dart';
import '../common/ScreenAdapter.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  Map arguments;

  ProductListPage(this.arguments);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //分页
  int _page = 1;

  //每页多少条数据
  int _pageSize = 8;

  //数据
  List _productList = [];

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
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('商品列表'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdaper.width(180),
                      height: ScreenAdaper.height(180),
                      child: Image.network(
                        'https://imgs.aixifan.com/style/image/201907/ccoYfmsvGxCTI9FVUTye8W6N6DLhQefn.jpg',
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
                              Text(
                                  "戴尔(DELL)灵越3670 英特尔酷睿i5 高性能 台式电脑整机(九代i5-9400 8G 256G)",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                                    //注意 如果Container里面加上decoration属性，这个时候color属性必须得放在BoxDecoration
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9),
                                    ),

                                    child: Text("4g"),
                                  ),
                                  Container(
                                    height: ScreenAdaper.height(36),
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromRGBO(230, 230, 230, 0.9),
                                    ),
                                    child: Text("126"),
                                  ),
                                ],
                              ),
                              Text(
                                "¥990",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Divider(height: 20)
              ],
            );
          },
        ),
      ),
    );
  }

  //请求列表数据
  Future _getProductListData() async {
    var api =
        '${Config.domain}api/plist?cid=${widget.arguments['cid']}&page=${this._page}&sort=${this._sort}&pageSize=${this._pageSize}';

    print(api);

    var result = await Dio().get(api);

    var productList = new ProductModel.fromJson(result.data);
    print( productList.result.length);
    if (productList.result.length < this._pageSize) {
      setState(() {
        this._productList = productList.result;
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
