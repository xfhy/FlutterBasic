//状态管理  依赖注入  provider
//我觉得这个的用处是可以跨组件传递数据.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///定义需要共享的数据模型  通过混入ChangeNotifier管理听众
///帮助管理所有依赖资源封装类的听众
class CounterModel with ChangeNotifier {
  int _count = 0;

  //读取_count的值
  int get counter => _count;

  //写方法
  void increment() {
    _count++;
    //通知听众刷新
    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //通过Provider组件封装数据资源
    //因Provider是InheritedWidget的语法糖,所以它是一个Widget
    return ChangeNotifierProvider.value(
      //需要共享的数据资源
      value: CounterModel(),
      child: MaterialApp(
        home: FirstPage(),
      ),
    );
  }
}

//示例: 读数据
class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取出资源  类型是CounterModel
    CounterModel _counter = Provider.of<CounterModel>(context);
    return Scaffold(
      body: Center(
        child: Text('Counter: ${_counter.counter}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Go'),
        onPressed: () =>
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SecondPage())),
      ),
    );
  }
}

//示例: 读和写数据
//使用Consumer 可以精准刷新发生变化的Widget
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //取出数据
    //final _counter = Provider.of<CounterModel>(context);
    return Scaffold(
      //使用Consumer来封装counter的读取
      body: Consumer(
        //builder函数可以直接获取到counter参数
        //Consumer 中的 builder 实际上就是真正刷新 UI 的函数，它接收 3 个参数，即 context、model 和 child
        builder: (context, CounterModel counter, _) =>
            Center(
                child: Text('Value: ${counter.counter}'),
            ),
      ),
      floatingActionButton: Consumer<CounterModel>(
        builder: (context, CounterModel counter, child) =>
            FloatingActionButton(
              onPressed: counter.increment,
              child: child,
            ),
        child: Icon(Icons.add),
      ),
    );
  }
}
