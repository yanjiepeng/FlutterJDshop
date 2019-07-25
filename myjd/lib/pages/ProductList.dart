import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import '../common/ScreenAdapter.dart';


class ProductListPage extends StatefulWidget {

  Map arguments;
  
  ProductListPage(this.arguments);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {



  @override
  Widget build(BuildContext context) {

    ScreenAdaper.init(context);


    return Scaffold(

      appBar: AppBar(

        title: Text('商品列表'),
      

      ),

      body:Padding(

        padding: EdgeInsets.all(10),
        child:
        
      ),

    );
  }
}