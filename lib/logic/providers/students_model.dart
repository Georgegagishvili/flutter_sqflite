import 'package:flutter/cupertino.dart';
import 'package:task_seven/logic/models/student.dart';
import 'package:task_seven/logic/services/students_db.dart';

class StudentsModel extends ChangeNotifier {
  List<Student> _students = [];
  bool _isLoading = true;

  List<Student> get getStudents => _students;
  bool get isLoading => _isLoading;

  loadStudents() async {
    _isLoading = true;

    _students = await StudentsDatabase.instance.readAllStudents();

    _isLoading = false;
    notifyListeners();
  }
}
