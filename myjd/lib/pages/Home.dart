import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import 'package:myjd/model/FocusModel.dart';
import 'package:myjd/config/config.dart';
import 'package:myjd/model/ProductModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  //加载轮播图
  List foucusData = [];
  List<ProductItemModel> hotProduct = [];
  List<ProductItemModel> bestProduct = [];

  @override
  void initState() {
    super.initState();

    _getFoucusData();
    _getHotProductData();
    _getBestProductData();
  }

  _getFoucusData() async {
    var api = '${Config.domain}api/focus';

    var result = await Dio().get(api);
    //得到的data.data是map类型
    // print (data.data);
    var focusList = FocusModel.fromJson(result.data);

    setState(() {
      this.foucusData = focusList.result;
    });
  }

  //获取猜你喜欢商品列表
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get('$api');
    var htproductList = ProductModel.fromJson(result.data);

    print(htproductList.result.length);
    setState(() {
      this.hotProduct = htproductList.result;
    });
  }

  //获取底部推荐商品列表
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get('$api');
    var htproductList = ProductModel.fromJson(result.data);

    print(htproductList.result.length);
    setState(() {
      this.bestProduct = htproductList.result;
    });
  }

  Widget _swiperWidget() {
    if (this.foucusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String pic = this.foucusData[index].pic;
              return new Image.network(
                "${Config.domain}${pic.replaceAll('\\', '/')}",
                fit: BoxFit.cover,
              );
            },
            itemCount: this.foucusData.length,
            pagination: new SwiperPagination(),
            autoplay: true,
          ),
        ),
      );
    } else {
      return Text('加载中');
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(32),
      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenUtil.getInstance().setWidth(10),
      ))),
      child: Text(
        value,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget getGuessLike() {
    if (this.hotProduct.length > 0) {
      return Container(
        height: ScreenUtil.getInstance().setHeight(234),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: this.hotProduct.length,
          itemBuilder: (BuildContext context, int index) {
            String spic = this.hotProduct[index].sPic;
            spic = '${Config.domain}${spic.replaceAll('\\', '/')}';
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      height: ScreenUtil.getInstance().setHeight(140),
                      width: ScreenUtil.getInstance().setHeight(140),
                      child: Image.network(
                        spic,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(10),
                  ),
                  Text(
                    "¥${this.hotProduct[index].price}",
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        height: ScreenUtil.getInstance().setHeight(234),
        child: Text('loading'),
      );
    }
  }

  //推荐商品
  //推荐商品
  Widget _recProductListWidget() {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: this.bestProduct.map((value) {
          //图片
          String sPic = value.sPic;
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return Container(
            padding: EdgeInsets.all(10),
            width: itemWidth,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    //防止服务器返回的图片大小不一致导致高度不一致问题
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      "$sPic",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Text(
                    "${value.title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "¥${value.price}",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("¥${value.oldPrice}",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //初始化适配工具
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: 10,
        ),
        _titleWidget('猜你喜欢'),
        getGuessLike(),
        _titleWidget("热门推荐"),
        _recProductListWidget()
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
