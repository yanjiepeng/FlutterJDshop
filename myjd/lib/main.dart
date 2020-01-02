import 'package:flutter/material.dart';
import 'package:myjd/routes/route.dart' as prefix0;
import 'package:provider/provider.dart';
import 'provider/Cart.dart';
import 'provider/Checkout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => Cart(),
        ),
         ChangeNotifierProvider(
          builder: (_) => Checkout(),
        ),
      ],
      child: MaterialApp(
        // home: Tabs(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: prefix0.onGenerateRoute,
        theme: ThemeData(
            // primaryColor: Colors.yellow
            primaryColor: Colors.white),
      ),
    );
  }
}
