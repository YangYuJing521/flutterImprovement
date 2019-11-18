// import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());
// 在编写应用程序时，通常会创建新的widget，
// 这些widget是无状态的StatelessWidget或者是有状态的StatefulWidget，
//  具体的选择取决于您的widget是理一些状态。
//  widget的主要工作是实现一个build函数，用以构建自否需要管身。

// void main() => runApp(
  //widget树由两个widget:Center(及其子widget)和Text组成。
//   Center(
//     child: Text(
//       'test widget',
//       textDirection: TextDirection.ltr,
//       ),
//   )
// );


// TODO 自定义appbar及material页面
// 在MyAppBar中创建一个Container，高度为56像素（像素单位独立于设备，为逻辑像素），其左侧和右侧均有8像素的填充。
// 在容器内部， MyAppBar使用Row 布局来排列其子项。
// 中间的title widget被标记为Expanded, ，这意味着它会填充尚未被其他子项占用的的剩余可用空间。
// Expanded可以拥有多个children， 然后使用flex参数来确定他们占用剩余空间的比例。
class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Widget子类中的字段往往都会定义为"final"
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue),
      //row 水平方向的线性布局（linear layout）
      child: Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'navigatorMenu',
            onPressed: null, //null 会禁用button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "search",
            onPressed: null,
          )
        ],
      ),
    );
  }
}

// MyScaffold 通过一个Column widget，在垂直方向排列其子项。
// 在Column的顶部，放置了一个MyAppBar实例，将一个Text widget作为其标题传递给应用程序栏。
// 将widget作为参数传递给其他widget是一种强大的技术，可以让您创建各种复杂的widget。
// 最后，MyScaffold使用了一个Expanded来填充剩余的空间，正中间包含一条message。
class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //// Material 是UI呈现的“一张纸”
    return Material(
      //Column is 垂直方向的线性布局
      child: Column(
        children: <Widget>[
           MyAppBar(
            title: Text(
              'example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('hello world'),
            ),
          )
        ],
      ),
    );
  }
}


// TODO 自定义带点击事件StatelessWidget
//自定义带点击事件按钮
class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //该GestureDetector widget并不具有显示效果，而是检测由用户做出的手势。
    //当用户点击Container时， GestureDetector会调用它的onTap回调， 在回调中，将消息打印到控制台。
    //您可以使用GestureDetector来检测各种输入手势，包括点击、拖动和缩放。
    // 许多widget都会使用一个GestureDetector为其他widget提供可选的回调。 
    // 例如，IconButton、 RaisedButton、 和FloatingActionButton ，
    // 它们都有一个onPressed回调，它会在用户点击该widget时被触发
    return GestureDetector(
      onTap: () {
        print('myButton was tapped');
      },
      child: Container(
        height: 36.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('engage'),
        ),
      ),
    );
  }
}

// TODO Counter
///statefulWidget
//无状态widget从它们的父widget接收参数， 它们被存储在final型的成员变量中。
// 当一个widget被要求构建时，它使用这些存储的值作为参数来构建widget。
//为了构建更复杂的体验 - 例如，以更有趣的方式对用户输入做出反应 - 应用程序通常会携带一些状态。
// Flutter使用StatefulWidgets来满足这种需求。
class Counter extends StatefulWidget {
  @override
  //createState函数require
  // State<StatefulWidget> createState() {
  //   return _CounterState();
  // }
  //简写
  _CounterState createState() => _CounterState();
}

//您可能想知道为什么StatefulWidget和State是单独的对象。
//在Flutter中，这两种类型的对象具有不同的生命周期： Widget是临时对象，用于构建当前状态下的应用程序，
//而State对象在多次调用build()之间保持不变，允许它们记住信息(状态)。
class _CounterState extends State {
  int _counter = 0;
  void _increment() {
    setState(() {
      _counter++;
    });
  }
  /*
  // 不拆分widget
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _increment,
          child: new Text('Increment'),
        ),
        new Text('count: $_counter'),
      ],
    );
  }
  */
  //widget 功能分离
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
       CounterIncrementor(onPressed: _increment),//new对象并传入回调
       CounterDisplay(count: _counter,),
      ],
    );
  }
  /*注意我们是如何创建了两个新的无状态widget的！
  我们清晰地分离了 显示 计数器（CounterDisplay）和 更改 计数器（CounterIncrementor）的逻辑。 
  尽管最终效果与前一个示例相同，但责任分离允许将复杂性逻辑封装在各个widget中，同时保持父项的简单性。*/
}

/*
widget结构层次的不同部分可能有不同的职责；
 例如，一个widget可能呈现一个复杂的用户界面，其目标是收集特定信息（如日期或位置），
 而另一个widget可能会使用该信息来更改整体的显示。
 在Flutter中，事件流是“向上”传递的，而状态流是“向下”传递的，重定向这一流程的共同父元素是State。
 */
//无状态的widget 显示count字符串
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});
  final int count;
  @override
  Widget build(BuildContext context) {
    return Text('Count: $count');
  }
}
//无状态的widget 显示按钮并接收回调参数
class CounterIncrementor extends StatelessWidget{

  CounterIncrementor({this.onPressed}); //接受调用参数 ->this.
  final VoidCallback onPressed; //接受的参数，无返回的回调
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: Text('increment'),
    );
  }
}

// TODO 整合综合练习-购物车

class Product {  //product 模型
//TODO const 初始化一次
  const Product({this.name});
  final String name;
}
//定义回调
// TODO 注意小写的void
typedef void CartChangeCallBack(Product product, bool inCart);

//cell  StatelessWidget  不做状态更改回调状态给父widget进行状态更改（刷新列表）
class ShoppingListItem extends StatelessWidget {

  ShoppingListItem({Product product, this.inCart, this.onCartChange})
      : product = product,
      super(key: ObjectKey(product));//object key，oc中的itentifier理解为重用
  //参数带_ 为私有
  final Product product;
  final bool inCart;
  final CartChangeCallBack onCartChange;

  //根据上下文获取颜色、字体 
  Color _getColor(BuildContext context) {
    //主题依赖于BuildContext因为树的不同部分有不同的主题，BuildContext表示当前主题
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }
  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    //列表
    return ListTile( //cell
      //当用户点击列表项时，widget不会直接修改其inCart的值。相反，widget会调用其父widget给它的onCartChanged回调函数。 
      //此模式可让您在widget层次结构中存储更高的状态，从而使状态持续更长的时间。
      onTap: () {
        onCartChange(product, !inCart);  //点击列表回调商品及购物车状态
      },
      leading: CircleAvatar( //头像
        backgroundColor: _getColor(context),
        child: Text(product.name[0]), //第一个字符
      ),
      title: Text(product.name, style: _getTextStyle(context),),  //名称
    );
  }
}


//StatefulWidget
class ShoppingList extends StatefulWidget {
  ShoppingList({Key key, this.products}) : super(key: key);
  final List<Product> products;
  @override
  // State<StatefulWidget> createState() {
  //   return new _ShoppingListState();
  // }
   _ShoppingListState createState() => _ShoppingListState();
}

//Scaffold
//TODO  State<ShoppingList> 一定要指明父类要不然会找不到products
class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = Set<Product>();

  void _handleCartChange(Product product, bool inCart) {
    setState(() {
      if (inCart) {
        _shoppingCart.add(product);
      } else {
        _shoppingCart.remove(product);
      }
    });
  }


  ///响应widget生命周期事件
  /*
  在StatefulWidget调用createState之后，框架将新的状态对象插入树中，然后调用状态对象的initState。
   子类化State可以重写initState，以完成仅需要执行一次的工作。
    例如，您可以重写initState以配置动画或订阅platform services。
    initState的实现中需要调用super.initState。*/
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  /*当一个状态对象不再需要时，框架调用状态对象的dispose。 您可以覆盖该dispose方法来执行清理工作。
  例如，您可以覆盖dispose取消定时器或取消订阅platform services。
   dispose典型的实现是直接调用super.dispose。*/
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text('Shooping List'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),//垂直cell间距
        children: widget.products.map((Product product) {
          return ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChange: _handleCartChange,
          );
        }).toList(),
      ),
    );    
  }
}

// TODO APP端的入口
/// APP端的入口
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //为了继承主题数据，widget需要位于MaterialApp内才能正常显示， 因此我们使用MaterialApp来运行该应用
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('test widget'),
      //   ),
      //   body: Center(
      //     // child: Text('test widget'),
      //     child: MyButton(),
      //   ),
      // ),
      // home: MyScaffold(),
      // home: TutorialHome(),
      home: ShoppingList(
      products: <Product>[
        Product(name: 'Eggs'),
        Product(name: 'Flour'),
        Product(name: 'Chocolate chips'),
      ],
    ),
 
    );
  }
}

// 从MyAppBar和MyScaffold切换到了AppBar和 Scaffold widget
class TutorialHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //该 Scaffold widget 需要许多不同的widget的作为命名参数，其中的每一个被放置在Scaffold布局中相应的位置
    return Scaffold(
      //我们给参数leading、actions、title分别传一个widget
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigaton Menu',
          onPressed: null,
        ),
        title: Text('example Title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'search',
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        // child: Text('this is body center'),
        child: Counter(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'ADD',
        child: Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}