import 'package:flutter/material.dart';
import '../common/ScreenAdapter.dart';
import 'package:dio/dio.dart';
import '../config/config.dart';

import '../model/CategoryModel.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int _selectIndex = 0;

  List<CategoryItemModel> _leftCategory = [];
  List<CategoryItemModel> _rightCategory = [];

  @override
  void initState() {
    super.initState();
    _getLeftCategory();
  }

  _getLeftCategory() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftList = CategoryModel.fromJson(result.data);
    print(leftList.result);
    setState(() {
      this._leftCategory = leftList.result;
    });
    print('pid=${this._leftCategory[0].sId}');
    _getRightCategory(this._leftCategory[0].sId);
  }

  _getRightCategory(String pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightList = CategoryModel.fromJson(result.data);
    print(rightList.result);
    setState(() {
      this._rightCategory = rightList.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    //右侧gridview每一项item的宽度
    var rightItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
    //右侧gridview每一项item的高度

    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    //转化为屏幕适配的尺寸
    //高度等于宽度+字体
    var rightItemHeight = rightItemWidth + ScreenAdapter.height(28);

    return Row(
      children: <Widget>[
        _leftWidgt(leftWidth),
        _rightWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }

  Expanded _rightWidget(rightItemWidth, rightItemHeight) {
    if (this._rightCategory.length > 0) {
      return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            itemCount: this._rightCategory.length,
            itemBuilder: (BuildContext context, int index) {
              String pic = this._rightCategory[index].pic;
              pic = Config.domain + pic.replaceAll('\\', '/');
              return InkWell(

                onTap: (){
                  Navigator.pushNamed(context, '/productlist',arguments: {'cid':this._rightCategory[index].sId});
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(
                          pic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: ScreenAdapter.height(28),
                        child: Text('${this._rightCategory[index].title}'),
                      )
                    ],
                  ),
                ),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth / rightItemHeight,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
            padding: EdgeInsets.all(10),
            height: double.infinity,
            color: Color.fromRGBO(240, 246, 246, 0.9),
            child: Center(
              child: Text('loading'),
            )),
      );
    }
  }

  Container _leftWidgt(leftWidth) {
    if (this._leftCategory.length > 0) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: this._leftCategory.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      this._selectIndex = index;
                      this._getRightCategory(this._leftCategory[index].sId);
                    });
                  },
                  child: Container(
                    child: Text(
                      '${this._leftCategory[index].title}',
                      textAlign: TextAlign.center,
                    ),
                    height: ScreenAdapter.height(84),
                    padding: EdgeInsets.only(top: ScreenAdapter.height(34)),
                    width: double.infinity,
                    color: this._selectIndex == index
                        ? Color.fromRGBO(240, 246, 246, 0.9)
                        : Colors.white,
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            );
          },
        ),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

}
