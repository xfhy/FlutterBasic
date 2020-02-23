import 'package:flutter/material.dart';

//Notification 从子->父 数据共享

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
  String _msg = "通知: ";

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
    return NotificationListener<CustomNotification>(
      onNotification: (notification) {
        setState(() {
          //收到子Widget通知,更新
          _msg += notification.msg + "  ";
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_msg),

          //按钮  按按钮的时候,发送通知
          CustomChild(),
        ],
      ),
    );
  }
}

class CustomNotification extends Notification {
  final String msg;

  CustomNotification(this.msg);
}

//抽离出一个子Widget用来发通知
class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => CustomNotification('Hi').dispatch(context),
      child: Text('发送通知'),
    );
  }
}
