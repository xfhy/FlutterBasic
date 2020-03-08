import 'package:flutter/material.dart';

///配置抽象
class AppConfig extends InheritedWidget {
  //主页标题
  final String appName;

  //接口域名
  final String apiBaseUrl;

  AppConfig(
      {@required this.appName,
      @required this.apiBaseUrl,
      @required Widget child})
      : super(child: child);

  //方便其子Widget在Widget树中找到它
  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  //判断是否需要子Widget更新.由于是应用入口,无需更新
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

///为不同的环境创建不同的应用入口

//main_dev.dart    这个是正式环境的入口
void main() {
  var configuredApp = AppConfig(
    appName: 'dev', //主页标题
    apiBaseUrl: 'http://dev.example.com/', //接口域名
    child: MyApp(),
  );
  runApp(configuredApp);
}

//main.dart   这个是测试环境的入口
/*void main(){
  var configuredApp = AppConfig(){
    appName: 'example',//主页标题
   apiBaseUrl: 'http://api.example.com/',//接口域名
   child: MyApp(),
  }
  runApp(configuredApp);
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return MaterialApp(
      title: config.appName,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(config.appName),
      ),
      body: Center(
        child: Text(config.apiBaseUrl),
      ),
    );
  }
}



//运行开发环境应用程序
//flutter run -t lib/main_dev.dart

//运行生产环境应用程序
//flutter run -t lib/main.dart

/*
*
//打包开发环境应用程序
flutter build apk -t lib/main_dev.dart
flutter build ios -t lib/main_dev.dart

//打包生产环境应用程序
flutter build apk -t lib/main.dart
flutter build ios -t lib/main.dart
* */