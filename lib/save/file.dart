//Flutter只提供渲染层,数据存储得靠底层的Android,iOS
//提供了3种,文件,SharedPreference,数据库

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('标题'),
      ),
      body: getContainer(),
    );
  }

  //创建文件目录   这里只是一个属性
  Future<File> get _localFile async {
    //获取应用文档目录
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    //data/user/0/com.xfhy.basic_ui/app_flutter
    print(path);
    return File('$path/content.txt');
  }

  //将字符串写入文件
  Future<File> writeContent(String content) async {
    final File file = await _localFile;
    return file.writeAsString(content);
  }

  //从文件读出字符串
  Future<String> readContent() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  static const String COUNTER_KEU = "counter";

  //读取SharedPreferences中key为counter的值
  Future<int> _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt(COUNTER_KEU) ?? 0);
    return counter;
  }

  Future<void> _increamentCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.get(COUNTER_KEU) ?? 0) + 1;
    await prefs.setInt(COUNTER_KEU, counter);
  }

  //----数据库----
  dbDemo() async {
    final Future<Database> database = openDatabase(
      //join是拼接路径分隔符
      join(await getDatabasesPath(), 'student_database.db'),
      onCreate: (db, version) => db.execute(
          "CREATE TABLE students(id TEXT PRIMARY KEY,name TEXT,score INTEGER)"),
      onUpgrade: (db, oldVersion, newVersion) {
        //dosth for 升级
      },
      version: 1,
    );

    Future<void> insertStudent(Student std) async {
      final Database db = await database;
      await db.insert(
        'students',
        std.toJson(),
        //插入冲突策略，新的替换旧的
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    //插入3个
    await insertStudent(student1);
    await insertStudent(student2);
    await insertStudent(student3);

    Future<List<Student>> students() async {
      final Database db = await database;
      final List<Map<String, dynamic>> maps = await db.query('students');
      return List.generate(maps.length, (i) => Student.fromJson(maps[i]));
    }

    ////读取出数据库中插入的Student对象集合
    students().then((list) => list.forEach((s) => print(s.name)));
    //释放数据库资源
    final Database db = await database;
    db.close();
  }

  getContainer() {
    return Column(
      children: <Widget>[
        RaisedButton(
          child: Text('文件读写'),
          onPressed: () {
            writeContent("hello world");
            readContent().then((value) => print(value));
          },
        ),
        RaisedButton(
          child: Text('SharedPreference读取'),
          onPressed: () {
            _increamentCounter().then((_) {
              _loadCounter().then((value) => print(value));
            });
          },
        ),
        RaisedButton(
          child: Text('数据库'),
          onPressed: () {
            dbDemo();
          },
        ),
      ],
    );
  }
}

var student1 = Student(id: '123', name: '张三', score: 90);
var student2 = Student(id: '456', name: '李四', score: 80);
var student3 = Student(id: '789', name: '王五', score: 85);

class Student {
  String id;
  String name;
  int score;

  //构造方法
  Student({
    this.id,
    this.name,
    this.score,
  });

  //用于将JSON字典转换成类对象的工厂类方法
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
      id: parsedJson['id'],
      name: parsedJson['name'],
      score: parsedJson['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'score': score};
  }
}
