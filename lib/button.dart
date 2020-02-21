import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: getFlatButton(),
    );
  }

  getFloatingActionButton() {
    return FloatingActionButton(
        child: Text('btn'),
        onPressed: () => print('我是FloatingActionButton,我被点击了'));
  }

  getFlatButton() {
    return FlatButton(
      color: Colors.yellow,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      //为避免按钮文字看不清楚，我们通过设置按钮主题 colorBrightness 为 Brightness.light，保证按钮文字颜色为深色。
      colorBrightness: Brightness.light,
      child: Row(
        children: <Widget>[
          Icon(Icons.add),
          Text(
            'FlatButton',
            style: TextStyle(color: Colors.red),
          )
        ],
      ),
      onPressed: () => print('我是FlatButton,默认背景是透明的'),
    );
  }

  getRaisedButton() {
    //是那种方块的,和Android默认Button很像的
    //onPressed参数为空,则是禁用状态
    return RaisedButton(
      //回调
      onPressed: () => print('我是getRaisedButton'),
      //按钮长什么样子
      child: Text('RaisedButton'),
    );
  }
}
