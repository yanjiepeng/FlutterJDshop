import 'package:flutter/material.dart';
import 'package:myjd/routes/route.dart' as prefix0;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),

      initialRoute: '/',
      onGenerateRoute: prefix0.onGenerateRoute,
    );
  }
}
