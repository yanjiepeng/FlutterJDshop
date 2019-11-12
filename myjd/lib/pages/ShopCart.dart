import 'package:flutter/material.dart';

import 'cart/cartpages/FirstCart.dart';

class ShopCartPage extends StatefulWidget {
  @override
  _ShopCarteState createState() => _ShopCarteState();

}

class _ShopCarteState extends State<ShopCartPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '全部()'),
    Tab(text: '降价()'),
    Tab(text: '常买()'),
    Tab(text: '分类()'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: TabBar(
              indicatorColor: Colors.redAccent,
              labelColor: Colors.black38,
              tabs: myTabs,
              isScrollable: false,
              controller: this._tabController,
              indicatorSize: TabBarIndicatorSize.label,
            ))
          ],
        ),
      ),
      body: TabBarView(
          controller: this._tabController,
          //TabBarView 默认支持手势滑动，若要禁止设置 NeverScrollableScrollPhysics
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            FirstCartPage(),
            Text('2'),
            Text('3'),
            Text('4'),
          ]),
    );
  }

  @override
  bool get wantKeepAlive => true;


}
