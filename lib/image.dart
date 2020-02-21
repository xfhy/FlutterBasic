import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Demo',
      theme: ThemeData(primaryColor: Colors.red),
      home: getImage(),
    );
  }

  getImage() {
    //加载本地资源 Image.asset('images/logo.png)
    //加载本地(File文件)图片,Image.file(new File('storage/xxx/test.png))
    //加载网络图片 Image.network('http://xxx/ss/test.gif')

    //FadeInImage 加入占位图,加载动画等
    return FadeInImage.assetNetwork(
      placeholder: 'assets/loading.gif',
      image: 'https://dss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white-c4d7df0a00.png',
      fit: BoxFit.fill,
      width: 200,
      height: 200,
    );
  }
}
