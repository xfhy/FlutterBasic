//在Dart层兼容Android/iOS平台特定实现
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //声明MethodChannel
  static const platform = MethodChannel('com.xfhy.basic_ui/util');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: getContainer(),
    );
  }

  handleButtonClick() async {
    bool result;
    //捕获  万一失败了呢
    try {
      //异步等待,可能很耗时  等待结果
      result = await platform.invokeMethod('isEmpty', "have data");
    } catch (e) {
      result = false;
    }
    print('result : $result');
  }

  getContainer() {
    return RaisedButton(
      child: Text('调用原生方法'),
      onPressed: () {
        handleButtonClick();
      },
    );
  }
}
