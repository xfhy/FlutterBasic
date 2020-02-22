import 'package:flutter/material.dart';

///2020年2月22日15:33:39  主题
/////defaultTargetPlatform == TargetPlatform.iOS  判断是否为iOS
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //全局的主题控制
      theme: ThemeData(
        //明暗模式为暗色
        brightness: Brightness.dark,
        //主色调
        primaryColor: Colors.cyan,
        //(按钮) Widget前景色为黑色
        accentColor: Colors.black,
        //设置icon主题色为黄色
        iconTheme: IconThemeData(color: Colors.yellow),
        //设置文本颜色为红色
        textTheme: TextTheme(body1: TextStyle(color: Colors.red)),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Demo'),
        ),
        body: getBody(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print('点击'),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        //1. 全局主题
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.favorite),
            Text('APP全局主题'),
          ],
        ),

        //2. 局部新建主题  Theme是单子Widget容器
        //不想继承任何 App 全局的颜色或字体样式，可以直接新建一个 ThemeData 实例，依次设置对应的样式
        Theme(
          data: ThemeData(iconTheme: IconThemeData(color: Colors.red)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite),
              Text('局部新建主题'),
            ],
          ),
        ),

        //3. 局部继承主题
        //而如果我们不想在局部重写所有的样式，则可以继承 App 的主题，使用 copyWith 方法，只更新部分样式
        Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Colors.green)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite),
              Text('局部继承主题'),
            ],
          ),
        ),

        //复用
        Container(
          //容器背景色复用应用主题色
          color: Theme.of(context).primaryColor,
          child: Text(
            'Text with a background color',
            //Text组件文本样式复用应用文本样式
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ],
    );
  }

  //

}
