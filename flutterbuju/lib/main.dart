
import 'package:flutter/material.dart';
import 'pageMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      // home: HomePage(),  // becomes the route named '/'
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => HomePage(),
      },
    );

    
  }
}


