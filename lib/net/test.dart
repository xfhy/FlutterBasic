import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'json.dart';

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

  static Student parseStudent(String content) {
    final jsonResponse = json.decode(jsonString);
    Student student = Student.fromJson(jsonResponse);
    return student;
  }

  doSth() {
    compute(parseStudent, jsonString)
        .then((student) => print(student.teacher.name));
  }

  getContainer() {
    return RaisedButton(
      child: Text('test'),
      onPressed: doSth,
    );
  }
}
