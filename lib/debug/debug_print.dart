import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

void main() {
  // 正式环境 将debugPrint指定为空的执行体, 所以它什么也不做
  debugPrint = (String message, {int wrapWidth}) {};
  debugPrint('test');

  //开发环境就需要打印出日志
  debugPrint = (String message, {int wrapWidth}) =>
      debugPrintSynchronously(message, wrapWidth: wrapWidth);
}



