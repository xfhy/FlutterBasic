import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///2020年2月22日21:35:49  与用户交互  指针事件   点击事件等

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: getParentChildGesture(),
    );
  }

  getListenerHome() {
    return Listener(
      child: Container(
        color: Colors.red,
        width: 300,
        height: 300,
      ),
      onPointerDown: (PointerDownEvent event) =>
          print('down $event ${event.position.dx}'),
      onPointerMove: (event) => print('move $event'),
      onPointerUp: (event) => print('up $event'),
    );
  }

  //父子都有点击事件的情况   因为子视图在父视图的上面,所以如果点击区域在子视图区域,子视图响应事件
  getParentChildGesture() {
    return GestureDetector(
      onTap: () => print('父视图点击回调'),
      child: Container(
        color: Colors.pinkAccent,
        child: Center(
          child: GestureDetector(
            onTap: () => print('子视图点击回调'),
            child: Container(
              color: Colors.blueAccent,
              width: 200,
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}

//-----------------------------双击,点击,长按,拖动事件------------------

class GestureApp extends StatefulWidget {
  @override
  State createState() {
    return GestureAppState();
  }
}

class GestureAppState extends State<GestureApp> {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return getGestureHome();
  }

  getGestureHome() {
    return Stack(
      children: <Widget>[
        //用来在Stack中定位的
        Positioned(
          top: _top,
          left: _left,
          //手势识别
          child: GestureDetector(
            child: Container(
              color: Colors.red,
              width: 50,
              height: 50,
            ),
            onTap: () => print('点击回调'),
            onDoubleTap: () => print('双击回调'),
            onLongPress: () => print('长按回调'),
            //拖动回调
            onPanUpdate: (e) {
              setState(() {
                _top += e.delta.dy;
                _left += e.delta.dx;
              });
            },
          ),
        ),
      ],
    );
  }
}
