import 'package:flutter/material.dart';

class AddAdressPage extends StatefulWidget {
  @override
  _AddAdressPageState createState() => _AddAdressPageState();
}

class _AddAdressPageState extends State<AddAdressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('增加收货地址'),
      ),
    );
  }
}
