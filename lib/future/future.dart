/*
void main(){
  Future(()=>print('f1'));
  print('外面');   //这句比上面那句先执行

  //Dart是单线程, 单线程和异步,不冲突

  Future(()=>print("f2")).then((_)=>print('f3'));  //then语句,f3会在f2之后马上执行
}*/

/*//异步函数  返回时其实执行动作并未结束
Future<String> fetchContent() =>
    Future<String>.delayed(Duration(seconds: 3), () => "hello").then((x)=>"$x "
        "2019");

void main() async {
  //这段代码是顺序执行
  print('前面');
  //异步等待
  print(await fetchContent());
  print('后面');
}*/

//Isolate  //多线程
/*import 'dart:isolate';

doSth(msg) => print(msg);

main() {
  Isolate.spawn(doSth, "hello");
}*/

import 'dart:isolate';

Isolate isolate;

start() async {
  ReceivePort receivePort = ReceivePort();
  //创建并发Isolate 并传入发送管道
  isolate = await Isolate.spawn(getMsg, receivePort.sendPort);
  //监听管道消息
  receivePort.listen((data) {
    print('Data: $data');
    //关闭管道
    receivePort.close();
    //杀死并发Isolate
    isolate?.kill(priority: Isolate.immediate);
    isolate = null;
  });
}

getMsg(SendPort sendPort) => (sendPort.send("hello"));
