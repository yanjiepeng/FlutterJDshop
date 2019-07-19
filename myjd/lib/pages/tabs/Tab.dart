import 'package:flutter/material.dart';
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
  List _pageList = [

      HomePage(),
      CategoryPage(),
      ShopCartPage(),
      MinePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
      ),
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex:this._currentIndex  ,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
            setState(() {
             this._currentIndex = index; 
            });
        },
        
        items: [
            BottomNavigationBarItem(icon: Icon(Icons.home) , title: Text('首页')),
            BottomNavigationBarItem(icon: Icon(Icons.category)  ,title: Text('分类')),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart)  ,title: Text('购物车')),
            BottomNavigationBarItem(icon: Icon(Icons.people)  ,title: Text('我的')),

        ],
      ),
    );
  }
}
