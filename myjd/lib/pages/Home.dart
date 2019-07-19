import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('首页'),
      
        RaisedButton(
            onPressed: (){
              Navigator.pushNamed(context, '/search');
            },
            child: Text('到跳转'),

        )
      ],


    );
  }
}