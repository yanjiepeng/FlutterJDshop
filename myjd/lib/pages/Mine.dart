import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MineeState createState() => _MineeState();
}

class _MineeState extends State<MinePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Text('我的');
  }

  @override
  bool get wantKeepAlive => true;
}