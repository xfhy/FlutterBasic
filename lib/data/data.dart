///跨组件传递数据
///InheritedWidget,Notification,EventBus

import 'package:flutter/material.dart';

///InheritedWidget是从上往下  父->子

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
  int count = 0;

  void _incrementCounter() => setState(() {
        count++;
      });

  @override
  Widget build(BuildContext context) {
    return CountContainer(
      //将自身作为model交给CountContainer
      model: this,
      //提供修改数据的方法
      increment: _incrementCounter,
      child: Counter(),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //获取InheritedWidget结点
    CountContainer state = CountContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: Text('times = ${state.model.count}'),
      floatingActionButton: FloatingActionButton(
        onPressed: state.increment,
      ),
    );
  }
}

class CountContainer extends InheritedWidget {
  //方便其子Widget在Widget树中找到它
  static CountContainer of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(CountContainer) as CountContainer;

  final _MyHomePageState model;
  final Function() increment;

  //required注解  虽然是可选参数,但是某些不选的话,就让IDE给你提示
  CountContainer(
      {Key key,
      @required this.model,
      @required this.increment,
      @required Widget child})
      : super(key: key, child: child);

  //判断是否需要更新
  @override
  bool updateShouldNotify(CountContainer oldWidget) {
    return /*model.count != oldwidget.model.count*/true;
  }
}
