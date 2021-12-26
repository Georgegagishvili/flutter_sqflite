const String tableStudents = 'students';

class StudentFields {
  static const List<String> values = [
    id,
    age,
    name,
  ];
  static const String id = '_id';
  static const String age = 'age';
  static const String name = 'name';
}

class Student {
  final int? id;
  final int age;
  final String name;

  Student({
    this.id,
    required this.age,
    required this.name,
  });

  static Student fromJson(Map<String, dynamic> json) => Student(
        id: json[StudentFields.id] as int,
        name: json[StudentFields.name] as String,
        age: json[StudentFields.age] as int,
      );

  Map<String, dynamic> toJson() => {
        StudentFields.id: id,
        StudentFields.name: name,
        StudentFields.age: age,
      };
}
