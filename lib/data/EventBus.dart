import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

///EventBus 不依赖Widget树   这是事件总线,666
/////遵循发布订阅 模式

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

//公共EventBus
EventBus eventBus = EventBus();

//第一个页面
class _FirstScreenState extends State<FirstScreen> {
  String msg = "通知";
  StreamSubscription subscription;

  @override
  initState() {
    //监听CustomEvent事件,刷新UI
    subscription = eventBus.on<CustomEvent>().listen((event) {
      setState(() {
        msg += event.msg;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page"),
      ),
      body: Text(msg),
      //跳转
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SecondScreen()))),
    );
  }

  @override
  void dispose() {
    //清理注册
    subscription.cancel();
    super.dispose();
  }
}

class FirstScreen extends StatefulWidget {
  @override
  State createState() {
    return _FirstScreenState();
  }
}

//待传递的事件
class CustomEvent {
  String msg;

  CustomEvent(this.msg);
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page"),
      ),
      body: RaisedButton(
        child: Text('发送事件'),
        //触发CustomEvent事件
        onPressed: () => eventBus.fire(CustomEvent('hello')),
      ),
    );
  }
}
