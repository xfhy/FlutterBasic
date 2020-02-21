import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Demo',
      theme: ThemeData(primaryColor: Colors.blue),
      home: getRichText(),
    );
  }

  getText() {
    return Text(
      '文本是视图系统中的常见控件，用来显示一段特定样式的字符串，就比如Android里的TextView，或是iOS中的UILabel。',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
    );
  }

  getRichText() {
    TextStyle whiteStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white);
    TextStyle redStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red);
    return Text.rich(
      TextSpan(children: <TextSpan>[
        //分片段
        TextSpan(text: '文本是视图系统中常见的控件，它用来显示一段特定样式的字符串，类似', style: redStyle),
        TextSpan(text: 'Android', style: whiteStyle),
        TextSpan(text: '中的', style: redStyle),
        TextSpan(text: 'TextView', style: whiteStyle),
      ]),
      textAlign: TextAlign.center,
    );
  }
}
