
import 'package:flutter/material.dart';

class TitleSection extends StatefulWidget {
  _FavariteWidgetState createState() => _FavariteWidgetState();
}

class _FavariteWidgetState extends State<TitleSection> {
  bool _isFavourite = true;
  int _favaoriteCount = 41;

  void _touchFavourite() {
    setState(() {
      if (_isFavourite) {
        _favaoriteCount -= 1;
        _isFavourite = false;
      } else {
        _favaoriteCount += 1;
        _isFavourite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
//标题行中的最后两项是一个红色的星形图标和文字“41”。将整行放在容器中，并沿着每个边缘填充32像素
      padding: EdgeInsets.all(32.0),
      //行
      child: Row(
        children: <Widget>[
          Expanded(//expanded自动填充空余
            child: Column(//正副标题是一个列
              crossAxisAlignment: CrossAxisAlignment.start,  //左对齐
              children: <Widget>[
                //将第一行文本放入Container中，然后底部添加8像素填充
                //如果要添加填充，边距，边框或背景色，请使用Container来设置
                Container(//正标题，带底部间距
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('Oeschinen Lake Campground',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                //副标题
                Text('Kandersteg, Switzerland',style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
           //五角星
          //  Icon(
          //    Icons.star,
          //    color: Colors.red
          //  ),
          //  Text('41')
          Row(
            mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0.0),
          child: IconButton(
            // icon: Icon(Icons.star),
            icon: _isFavourite? Icon(Icons.star):Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: _touchFavourite,
          ),
        ),
        SizedBox(
          width: 18.0,
          child: Container(
            child: Text('$_favaoriteCount'),
          ),
        )
      ],
    )
        ],
      ),
    );

     
  }
}

class HomePage extends StatelessWidget {

       /*Flutter布局机制的核心就是widget。在Flutter中，几乎所有东西都是一个widget - 甚至布局模型都是widget。
    您在Flutter应用中看到的图像、图标和文本都是widget。 
    甚至你看不到的东西也是widget，例如行（row）、列（column）以及用来排列、
    约束和对齐这些可见widget的网格（grid）。
    
    Container也是一个widget，允许您自定义其子widget。
    如果要添加填充，边距，边框或背景色，请使用Container来设置（译者语：只有容器有这些属性）。

    所有布局widget都有一个child属性（例如Center或Container），或者一个 children属性，
    如果他们需要一个widget列表（例如Row，Column，ListView或Stack）

    Flutter应用本身就是一个widget，大部分widget都有一个build()方法。
    在应用程序的build方法中创建会在设备上显示的widget。 
    对于Material应用程序，您可以将Center widget直接添加到body属性中
    对于非Material应用程序，您可以将Center widget添加到应用程序的build()方法中：
    
    要在Flutter中创建行或列，可以将一个widget列表添加到Row 或Column 中。
    同时，每个孩子本身可以是一个Row或一个Column，依此类推。以下示例显示如何在行或列内嵌套行或列。
    */

  @override
  Widget build(BuildContext context) {

    //TODO 标题行
    // Widget titleSection = Container(
      
    // );

    // TODO 创建按钮行的私有方法
    //由于构建每个列的代码几乎是相同的，因此使用一个嵌套函数，如buildButtonColumn,
    //构建函数将图标直接添加到列（Column）中。
    Column buildButtonColumn(String label, IconData icon) {
      Color buttonColor = Theme.of(context).primaryColor;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,

        children: <Widget>[
          Icon(icon, color: buttonColor),
          //将文本放入容器以在文本上方添加填充，将其与图标分开
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: buttonColor
              )
            ),
          )
        ],
      );
    }
    //TODO 按钮行
    Widget buttonSection = Container(
      child: Row(
        //然后在行的主轴方向通过 MainAxisAlignment.spaceEvenly 平均的分配每个列占据的行空间
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn('Call', Icons.call),
          buildButtonColumn('Route', Icons.near_me),
          buildButtonColumn('Share', Icons.share),
        ],
      ),
    );

    //TODO 文本行
    Widget textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.',
        //softwrap属性表示文本是否应在软换行符（例如句点或逗号）之间断开
        softWrap: true,
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('flutter 布局'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset(
            'images/lake.jpg',
            width: 500.0,
            height: 240.0,
            fit: BoxFit.cover,
          ),
          TitleSection(),
          buttonSection,
          textSection,
        ],
      ),
    );
  }
}