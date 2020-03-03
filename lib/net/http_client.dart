import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

//在Flutter中,所有网络编程框架都是以Future作为异步请求的包装
//1. http-client方式请求网络
get() async {
  //创建网络调用实例,设置通用请求行为(超时时间)
  var httpClient = HttpClient();
  httpClient.idleTimeout = Duration(seconds: 5);

  //构建URI,设置user-agent为"Custom-UA"
  var uri = Uri.parse("http://www.baidu.com/");
  var request = await httpClient.getUrl(uri);
  request.headers.add("user-agent", "Custom-UA");

  //发起请求,打印结果
  var response = await request.close();

  if (response.statusCode == HttpStatus.ok) {
    print(await response.transform(utf8.decoder).join());
  } else {
    print('Error: \nHttp status ${response.statusCode}');
  }
}

//2. http方式
//这是Dart官方提供的另一个网络请求库,相比于HTTPClient,方便不少
httpGet() async {
  //创建网络调用实例
  var client = http.Client();

  //构造URI
  var uri = Uri.parse("http://www.baidu.com/");

  //设置user-agent为Custom-UA 随后立即发出请求
  http.Response response =
      await client.get(uri, headers: {"user-agent": "Custom-UA"});

  if (response.statusCode == HttpStatus.ok) {
    print(response.body);
  } else {
    print("Error ${response.statusCode}");
  }
}

//3. dio  极力推荐使用,这个是第三方的,上面的方式使用起来太繁琐了
//取消请求,定制拦截器,Cookie管理等
//dio是一个强大的Dart Http请求库，支持Restful API、FormData、拦截器、请求取消、Cookie管理、文件上传/下载、超时、自定义适配器等...
void getRequest() async {
  //创建网络调用实例
  Dio dio = new Dio();

  //设置URI及请求user-agent后发起请求
  var response = await dio.get("http://www.baidu.com",
      options: Options(headers: {"user-agent": "Custom-UA"}));

  //打印请求结果
  if (response.statusCode == HttpStatus.ok) {
    print(response.data.toString());
  } else {
    print("Error ${response.statusCode}");
  }
}

//下载和上传
/*void download() async {
  var dio = Dio();
//使用FormData表单构建待上传文件
  */ /*FormData formData = FormData.from({
    "file1": UploadFileInfo(File("./file1.txt"), "file1.txt"),
    "file2": UploadFileInfo(File("./file2.txt"), "file1.txt"),
  });*/ /*
//通过post方法发送至服务端
  var responseY = await dio.post("https://xxx.com/upload", data: formData);
  print(responseY.toString());

//使用download方法下载文件
  dio.download("https://xxx.com/file1", "xx1.zip");

//增加下载进度回调函数
  dio.download("https://xxx.com/file1", "xx2.zip",
      onReceiveProgress: (count, total) {
    //do something
  });
}*/

//多个请求都拿到结果才刷新界面
void parallel() async {
  var dio = Dio();

  //同时发起2个并行请求
  List<Response> responseX = await Future.wait(
      [dio.get("http://www.baidu.com"), dio.get("http://www.qq.com")]);

  print('response0 ${responseX[0].toString()}');
  print('response1 ${responseX[1].toString()}');
}

//拦截器  可以在请求之前或者响应之后做一些特殊操作
//比如增加header 返回缓存数据,本地校验等
void interceptor() async {
  //加上了自定义的 user-agent，还实现了基本的 token 认证信息检查功能。而对于本地已经缓存了请求 uri 资源的场景，我们可以直接返回缓存数据，避免再次下载：
  var dio = Dio();

  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    //为每个请求头都增加user-agent
    options.headers["user-agent"] = "Custom-UA";
    //检查是否有token 没有则直接报错
    if (options.headers['token'] == null) {
      return dio.reject('Error:请先登录');
    }
    //检查缓存是否有数据
    if (options.uri == Uri.parse('http://xxx.com.file1')) {
      return dio.resolve("返回缓存数据");
    }
    return options;
  }));

  //包起来,防止请求出错
  //可能出现异常,比如域名无法解析,超时等
  try {
    var response = await dio.get("https://xxx.com/xxx.zip");
    print(response.data.toString());
  } catch (e) {
    print(e);
  }
}

void main() {
//  get();
//  httpGet();
//  getRequest();
  //download();
  parallel();
}
