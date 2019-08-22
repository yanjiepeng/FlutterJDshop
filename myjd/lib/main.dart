import 'package:flutter/material.dart';
import 'package:myjd/routes/route.dart' as prefix0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Tabs(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/search',
      onGenerateRoute:prefix0.onGenerateRoute,
      theme: ThemeData(
        // primaryColor: Colors.yellow
          primaryColor: Colors.white
      ),
    );
  }
}
