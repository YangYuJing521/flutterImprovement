import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter key'),
    );
  }
}

Color getRandomColor() {
    return Color.fromARGB(255, 
    Random.secure().nextInt(255), 
    Random.secure().nextInt(255), 
    Random.secure().nextInt(255));
}


// class StatelessContainer extends StatelessWidget {
//   final Color randomCol = getRandomColor();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       color: randomCol,
//     );
//   }
// }


class StatefulContainer extends StatefulWidget {
  @override
  _StatefulContainerState createState() => _StatefulContainerState();
}

class _StatefulContainerState extends State<StatefulContainer> {
  final Color randomCol = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: randomCol,
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<Widget> widgets;

  //初始化加载资源
  @override
  void initState() {
    super.initState();
    widgets =  [StatefulContainer(), StatefulContainer()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchWidget,
        tooltip: 'change',
        child: Icon(Icons.import_export),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  //点击事件
  switchWidget(){
    setState(() {
      widgets.insert(0, widgets.removeAt(1));
    });
  }
}
