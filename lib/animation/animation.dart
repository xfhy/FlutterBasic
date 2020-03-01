import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      /*home: new Scaffold(
        body: NormalAnimateApp(),
      ),*/
      home: Page1(),
    );
  }
}

class NormalAnimateApp extends StatefulWidget {
  @override
  State createState() {
    return _AnimateAppState();
  }
}

class _AnimateAppState extends State<NormalAnimateApp>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    //创建动画周期为1秒的AnimationController对象
    //用于管理Animation
    controller = AnimationController(
      vsync: this, //防止出现不可见动画
      duration: const Duration(milliseconds: 1000),
    );

    //可选
    //创建一条震荡曲线
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.elasticInOut,
    );

    //提供动画数据,不负责渲染
    //创建从50到200线性变化的Animation对象
    //普通动画需要手动监听动画状态,刷新UI   .animate(controller)
    animation = Tween(begin: 50.0, end: 200.0).animate(curvedAnimation)
      //换行之后,继续调用方法
      ..addListener(() => setState(() {}));

    //可选
    //添加监听器
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画结束
      } else if (status == AnimationStatus.dismissed) {
        //动画反向执行完毕时
      }
    });

    //启动动画
//    controller.forward();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: animation.value,
        height: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    //及时释放资源
    controller.dispose();
    super.dispose();
  }
}

//--------------AnimatedWidget-----------
//使用AnimatedWidget的时候,只需要把Animation传入即可,不用自己监听动画执行进度手动刷新UI
class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    //取出动画对象
    final Animation<double> animation = listenable;
    return Center(
      child: Container(
        width: animation.value,
        height: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

//------hero动画-------
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        //用hero包起来
        child: Hero(
          tag: 'hero',
          child: Container(
            width: 100,
            height: 100,
            child: FlutterLogo(),
          ),
        ),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Page2()));
        },
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: 'hero',
        child: Container(
          width: 300,
          height: 300,
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
