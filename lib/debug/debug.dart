import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///运行时识别应用的编译模式:
///1. 可以用个断言识别
///2. 可以通过Darm Vm所提供的编译常数识别

/// 如果想在整个应用层面,为不同的运行环境提供更为统一的配置,则需要在应用启动入口提供可配置的初始化方式,根据特定需求为应用注入配置环境
/// 比如正式环境和测试环境的接口域名不一样

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
      body: getContainer(),
    );
  }

  getContainer() {
    String text;
    if (kReleaseMode) {
      //正式环境
      text = "release";
    } else {
      //测试环境  debug
      text = "debug";
    }
    return Text(text);
  }
}
