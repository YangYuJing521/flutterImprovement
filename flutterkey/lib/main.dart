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

class StatelessContainer extends StatelessWidget {
  StatelessContainer({Key key}) : super(key: key);
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

class StatefulContainer extends StatefulWidget {
  StatefulContainer({Key key}) : super(key: key);
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

// TODO global key practice
class SwitchScreen extends StatefulWidget {
  //接受key
  SwitchScreen({Key key}) : super(key: key);
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) { 
    return Switch.adaptive(
      value: isActive,
      onChanged: (bool currentState){
        setState(() {
          isActive = currentState;
        });
      },
    );
  }

  changeState() {
    setState(() {
      isActive = !isActive;
    });
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
    widgets =  [
      // StatefulContainer(key: UniqueKey(),),
      // StatefulContainer(key: UniqueKey(),)

      // StatefulContainer(),
      // StatefulContainer()

      // StatelessContainer(),
      // StatelessContainer()

      Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: StatefulContainer(),
      ),
      Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: StatefulContainer(),
      )
      ];

  }

  //global key
  final GlobalKey<_SwitchScreenState> gKey = GlobalKey<_SwitchScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: widgets,
        // ),
        
        //global key
        child: SwitchScreen(key: gKey,),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: switchWidget,//交换颜色块
        onPressed: switchSwitch,  //更改switch状态
        tooltip: 'change',
        child: Icon(Icons.import_export),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  bool canBeUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
  //点击事件 交换字块
  switchWidget(){
    setState(() {
    bool canUpdate = canBeUpdate(widgets[0], widgets[1]);
    print(canUpdate);

    Type type1 = widgets[0].runtimeType;
    Type type2 = widgets[1].runtimeType;
    Key key1 = widgets[0].key;
    Key key2 = widgets[1].key;
    
    print(type1);
    print(type2);
    print(key1);
    print(key2);
    widgets.insert(0, widgets.removeAt(1));
    });
  }

  //点击事件 global key
  switchSwitch() {
    setState(() {
      gKey.currentState.changeState();
    });
  }
}

 
