import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/eventbus/CartEvent.dart';
import 'package:myjd/pages/Category.dart';
import 'package:myjd/pages/Home.dart';
import 'package:myjd/pages/Mine.dart';
import 'package:myjd/pages/ShopCart.dart';
import 'package:myjd/service/SignService.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  PageController _pageController;
  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    ShopCartPage(),
    MinePage(),
  ];

  var _isEdit = false;

  get isEdit => _isEdit;

  var event;
  @override
  void initState() {
    super.initState();
    this._pageController = PageController(initialPage: this._currentIndex);


    event = eventBus.on<TabEvent>().listen((event){

       int index = event.index;
       setState(() {
         this._currentIndex = index;
         this._pageController.jumpToPage(this._currentIndex);
       });

    });




  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    event.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    SignService.getSign('123');

    return Scaffold(
      appBar: getAppBar(this._currentIndex),
      body: PageView(
        //TabBarView 默认支持手势滑动，若要禁止设置 NeverScrollableScrollPhysics
        physics: NeverScrollableScrollPhysics(),
        controller: this._pageController,
        children: this._pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        onTap: (index) {
          setState(() {
            this._currentIndex = index;
            this._pageController.jumpToPage(this._currentIndex);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), title: Text('分类')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('购物车')),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text('我的')),
        ],
      ),
    );
  }

  AppBar getAppBar(var index) {
    if (index == 0 || index == 1) {
      return AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.center_focus_weak,
              size: 28,
              color: Colors.black87,
            ),
            onPressed: null),
        title: InkWell(
          child: Container(
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(233, 233, 233, 0.9)),
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                Icon(Icons.search),
                Text(
                  '笔记本',
                  style: TextStyle(fontSize: ScreenAdapter.size(18)),
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.message,
                size: 28,
                color: Colors.black87,
              ),
              onPressed: null)
        ],
      );
    } else if (index == 2) {
      return AppBar(
        backgroundColor: Colors.red,
        leading: Icon(null),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '购物车',
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.add_location,
              color: Colors.white,
            )
          ],
        ),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  this._isEdit = !this._isEdit;
                });
                eventBus.fire(new EditEvent(this._isEdit));
              },
              child: Text(
                '编辑',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ]),
          IconButton(
              icon: Icon(
                Icons.more_horiz,
                size: 28,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      );
    } else {
      return null;
    }
  }
}
