import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: getContainer(),
      ),
    );
  }

  //单子Widget---------------------------------

  getContainer() {
    return Container(
      child: Center(
        child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
      ),
      //内边距
      padding: EdgeInsets.all(18.0),
      //外边距
      margin: EdgeInsets.all(44.0),
      width: 180.0,
      height: 240,
      //子Widget居中对齐
      /* alignment: Alignment.center,*/
      //Container样式
      decoration: BoxDecoration(
        //背景色
        color: Colors.red,
        //圆角边框
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  getPadding() {
    //只需要设置边距 可以使用Padding
    return Padding(
      padding: EdgeInsets.all(44.0),
      child: Text('我是Padding'),
    );
  }

  getCenter() {
    //直接居中
    return Center(
      child: Text('center text'),
    );
  }

  //多子Widget Row:水平排列  Column:垂直排列
  getRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          //弹性系数 设置为1,会将剩余空间占满,按比例平分
          flex: 1,
          child: Container(
            color: Colors.red,
            width: 60,
            height: 80,
          ),
        ),
        Container(
          color: Colors.green,
          width: 45,
          height: 45,
        ),
        Container(
          color: Colors.orange,
          width: 78,
          height: 56,
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.yellow,
            width: 60,
            height: 80,
          ),
        ),
      ],
    );
  }

  getColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          color: Colors.yellow,
          width: 60,
          //不设置高度的话,子Widget多高就是多高
//          height: 80,
          child: Text('dasdas'),
        ),
        Container(
          color: Colors.orange,
          width: 60,
          height: 80,
        ),
        Container(
          color: Colors.red,
          width: 60,
          height: 80,
        ),
        Container(
          color: Colors.blue,
          width: 60,
          height: 180,
        ),
      ],
    );
  }

  //层叠Widget布局
  getStack() {
    //Stack用来装东西 Positioned用来设置子Widget位置
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.yellow,
          width: 300,
          height: 300,
        ),

        //控制位置
        Positioned(
          left: 18.0,
          top: 18.0,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ),

        Positioned(
          left: 15,
          top: 45,
          child: Text('Stack提供了层叠布局的容器'),
        ),
      ],
    );
  }
}
