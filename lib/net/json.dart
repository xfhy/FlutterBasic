import 'dart:convert';

String jsonString = '''
{
  "id":"123",
  "name":"张三",
  "score" : 95,
  "teacher": { "name": "李四", "age" : 40 }
}
''';

//json解析

//所谓手动解析，是指使用 dart:convert 库中内置的 JSON 解码器，将 JSON 字符串解析成自定义对象的过程。

class Teacher {
  String name;
  int age;

  Teacher({this.name, this.age});

  factory Teacher.fromJson(Map<String, dynamic> parsedJson) {
    return Teacher(name: parsedJson['name'], age: parsedJson['age']);
  }

  @override
  String toString() {
    return 'Teacher{name: $name, age: $age}';
  }
}

class Student {
  String id;
  String name;
  int score;
  Teacher teacher;

  Student({this.id, this.name, this.score, this.teacher});

  //从Map中取
  factory Student.fromJson(Map<String, dynamic> parsedJson) {
    return Student(
        id: parsedJson['id'],
        name: parsedJson['name'],
        score: parsedJson['score'],
        teacher: Teacher.fromJson(parsedJson['teacher']));
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, score: $score, teacher: $teacher}';
  }
}


void main() {

  final jsonResponse = json.decode(jsonString);//将字符串解码成Map对象
  Student student = Student.fromJson(jsonResponse);//手动解析
  print(student.teacher.name);
}
