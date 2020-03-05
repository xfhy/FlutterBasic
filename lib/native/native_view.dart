//平台视图  将原生View插入到Flutter视图树中
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///新起一个页面,这是通用的模板
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

//原生视图Flutter侧封装,继承自StatefulWidget
class SampleView extends StatefulWidget {
  const SampleView({Key key, this.controller}) : super(key: key);

  final NativeViewController controller;

  @override
  State createState() {
    return _SampleViewState();
  }
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    //使用Android平台的AndroidView,传入唯一标识符sampleView
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'sampleView',
        //原生视图创建完成之后,通过onPlatformViewCreated产生回调
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else {
      //iOS平台
      return UiKitView(
        viewType: 'sampleView',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
  }

  _onPlatformViewCreated(int id) {
    if (widget.controller == null) {
      return;
    }
    widget.controller.onCreate(id);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NativeViewController controller = new NativeViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: getContainer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeBackgroundColor(),
      ),
    );
  }

  getContainer() {
    return Container(
      width: 300,
      height: 300,
      child: SampleView(
        controller: controller,
      ),
    );
  }
}

class NativeViewController {
  MethodChannel _channel;

  //用MethodChannel于原生通信,根据ID生成唯一方法通道
  onCreate(int id) {
    _channel = MethodChannel('samples.chenhang/native_views_$id');
  }

  //调用原生方法,改变颜色
  Future<void> changeBackgroundColor() async {
    return _channel.invokeMethod('changeBackgroundColor');
  }
}
