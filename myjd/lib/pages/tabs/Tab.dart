import 'package:flutter/material.dart';
import 'package:myjd/common/ScreenAdapter.dart';
import 'package:myjd/pages/Category.dart';
import 'package:myjd/pages/Home.dart';
import 'package:myjd/pages/Mine.dart';
import 'package:myjd/pages/ShopCart.dart';

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

  @override
  void initState() {
    super.initState();
    this._pageController = PageController(initialPage: this._currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);

    return Scaffold(
      appBar: this._currentIndex != 3
          ? AppBar(
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
                onTap: (){
                  Navigator.pushNamed(context, '/search');
                },
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.message , size: 28, color: Colors.black87,), onPressed: null)
              ],
            )
          : AppBar(
        
        title: Text('企业中心'),
        
      ),
      body: PageView(
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
}
