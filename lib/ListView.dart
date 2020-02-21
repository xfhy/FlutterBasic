import 'package:flutter/material.dart';

void main() => runApp(MyListenerApp());

//--------------------------------NotificationListener
class MyListenerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: NotificationListener<ScrollNotification>(
          //添加NotificationListener作为父容器
          //注册通知回调
          onNotification: (scrollNotification) {
            //开始滑动
            if (scrollNotification is ScrollStartNotification) {
              //scrollNotification.metrics.pixels 滑动的位置
              print('scroll start ${scrollNotification.metrics.pixels}');
            } else if (scrollNotification is ScrollUpdateNotification) {
              //滑动中
              print('scroll update');
            } else if (scrollNotification is ScrollEndNotification) {
              //滑动结束
              print('scroll end');
            }
            return null;
          },
          child: ListView.builder(
              itemCount: 100,
              itemExtent: 70,
              itemBuilder: (context, index) => ListTile(
                    title: Text('index $index'),
                  )),
        ),
      ),
    );
  }
}

//------------------------------ScrollController
class MyControllerAppState extends State<MyControllerApp> {
  //ListView控制器
  ScrollController _controller;

  //标识目前是否需要启用top按钮
  bool isToTop = false;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      //ListView向下滚动1000 则启用top按钮
      if (_controller.offset > 1000) {
        setState(() {
          isToTop = true;
        });
      } else if (_controller.offset < 300) {
        //向下滚动不足300,则禁用按钮
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
            //将控制器传入
            controller: _controller,
            itemCount: 100,
            itemExtent: 100,
            itemBuilder: (context, index) =>
                ListTile(title: Text('index $index'))),
        floatingActionButton: RaisedButton(
          //如果isToTop是true则滑动到顶部,否则禁用按钮
          onPressed: isToTop
              ? () {
                  //滑动到顶部
                  _controller.animateTo(0.0,
                      duration: Duration(microseconds: 200),
                      curve: Curves.ease);
                }
              : null,
          child: Text('top'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}

class MyControllerApp extends StatefulWidget {
  @override
  State createState() {
    return MyControllerAppState();
  }
}

//------------------------------------------------- 基本
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: Scaffold(
        /* // 可用于增加标题栏
       appBar: AppBar(
          title: Text('ListView'),
        ),*/
        floatingActionButton: RaisedButton(onPressed: null),
        body: getCustomScrollView(),
      ),
    );
  }

  getListView() {
    return ListView(
      children: <Widget>[
        //ListTile用于快速构建列表项元素  官方文档 https://api.flutter.dev/flutter/material/ListTile-class.html
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text('mail'),
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('message'),
        ),
      ],
    );
  }

  getHorizontalListView() {
    //最好是抽象出创建子Widget的方法,交由ListView统一管理,真正需要展示该子Widget的时候再去创建
    return ListView(
      //水平方向
      scrollDirection: Axis.horizontal,
      itemExtent: 140, //item延展尺寸(宽度)
      children: <Widget>[
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.blue,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.orange,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }

  getListViewByBuilder() {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text('title $index'),
              subtitle: Text('subtitle $index'),
            ),
        separatorBuilder: (BuildContext context, int index) => index % 2 == 0
            ? Divider(
                color: Colors.green,
              )
            : Divider(
                color: Colors.red,
              ),
        itemCount: 100);

    /*
      不带分割线
      ListView.builder(
        itemCount: 100, //元素个数
        itemExtent: 50.0, //列表项高度
        itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text('title $index'),
              subtitle: Text('subtitle $index'),
            ));*/
  }

  //多个滑动控件嵌套
  getCustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('CustomScrollView Demo'), //标题
          floating: true, //设置成悬浮样式
          flexibleSpace: Image.network(
            'https://cn.bing.com/th?id=OHR.UffingStaffelseeWinter_ZH-CN4001263375_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp',
            fit: BoxFit.cover,
          ), //设置悬浮头图背景
          expandedHeight: 300, //头图控件高度
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => ListTile(
                  title: Text('Item $index'),
                ))),
      ],
    );
  }
}
