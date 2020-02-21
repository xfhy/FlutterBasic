import 'dart:math';

import 'package:flutter/material.dart';

///组合控件  自定义控件   也可以自己画
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: getCake(),
    );
  }

  getCake() {
    return Cake();
  }

  getCombination() {
    return UpdateItem(
      model: UpdateItemModel(
          appIcon: "assets/icon.png",
          appDescription:
              "Thanks for using Google Maps! This release brings bug fixes that improve our product to help you discover new places and navigate to them.",
          appName: "Google Maps - Transit & Fond",
          appSize: "137.2",
          appVersion: "Version 5.19",
          appDate: "2019年6月5日"),
      onPressedCallback: () {
        print('按钮被点击了');
      },
    );
  }
}

class UpdateItem extends StatelessWidget {
  //数据模型
  final UpdateItemModel model;
  final VoidCallback onPressedCallback;

  //可选
  UpdateItem({Key key, this.model, this.onPressedCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getTopItem(),
        getBottomItem(),
      ],
    );
  }

  getTopItem() {
    //Row控件,用来水平摆放子Widget
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          //ClipRRect:圆角矩形裁剪控件
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/icon.png',
              width: 80,
              height: 80,
            ),
          ),
        ),
        //拉伸中间区域
        Expanded(
          child: Column(
            //主轴(垂直): 居中
            mainAxisAlignment: MainAxisAlignment.center,
            //纵轴(水平): 居左
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.appName,
                maxLines: 1,
              ),
              Text(
                model.appDate,
                maxLines: 1,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: FlatButton(
            //平时的背景
            color: Color(0xFFF1F0F7),
            //按下时背景
            highlightColor: Colors.blue[700],
            onPressed: onPressedCallback,
            //按钮圆角
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              'OPEN',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  getBottomItem() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        //纵轴(水平) 居左
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(model.appDescription),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Text('${model.appVersion} • ${model.appSize} MB'),
          ),
        ],
      ),
    );
  }
}

//item 的model
class UpdateItemModel {
  //为了简单起见,这里全部设置成String
  String appIcon;
  String appName;
  String appSize;
  String appDate;
  String appDescription;
  String appVersion;

  //构造函数语法糖,为属性赋值
  UpdateItemModel(
      {this.appIcon,
      this.appName,
      this.appSize,
      this.appDate,
      this.appDescription,
      this.appVersion});
}

//-----------------自己画的控件--------------------
class WheelPainter extends CustomPainter {
  Paint getColoredPaint(Color color) {
    Paint paint = Paint();
    paint.color = color;
    return paint;
  }

  @override
  void paint(Canvas canvas, Size size) {
    //半径
    double wheelSize = min(size.width, size.height) / 2;
    //分成6份
    double nbElem = 6;
    //角度
    double radius = (2 * pi) / nbElem;
    //包裹饼图的矩形框  center:相对于原点的偏移量
    Rect boundingRect = Rect.fromCircle(
        center: Offset(wheelSize, wheelSize), radius: wheelSize);

    //每次画1/6圆
    canvas.drawArc(
        boundingRect, 0, radius, true, getColoredPaint(Colors.orange));
    canvas.drawArc(
        boundingRect, radius, radius, true, getColoredPaint(Colors.green));
    canvas.drawArc(
        boundingRect, radius * 2, radius, true, getColoredPaint(Colors.red));
    canvas.drawArc(
        boundingRect, radius * 3, radius, true, getColoredPaint(Colors.blue));
    canvas.drawArc(
        boundingRect, radius * 4, radius, true, getColoredPaint(Colors.pink));
    canvas.drawArc(boundingRect, radius * 5, radius, true,
        getColoredPaint(Colors.deepOrange));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    //判断是否需要重绘,简单做下比较
    return oldDelegate != this;
  }
}

class Cake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //CustomPaint是用来承载自定义View的容器,需要自定义一个画笔,得继承自CustomPainter
    return CustomPaint(
      size: Size(200, 200),
      painter: WheelPainter(),
    );
  }
}
