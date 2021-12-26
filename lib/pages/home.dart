import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_seven/logic/models/student.dart';
import 'package:task_seven/logic/providers/students_model.dart';
import 'package:task_seven/logic/services/students_db.dart';
import 'package:task_seven/pages/add_student.dart';
import 'package:task_seven/widgets/default_appbar.dart';
import 'package:task_seven/widgets/student_node.dart';

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<StudentsModel>(context, listen: false).loadStudents();
  }

  @override
  void dispose() {
    StudentsDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Students SQFLITE',
      ),
      body: Column(
        children: [
          Flexible(
            child: Consumer<StudentsModel>(builder: (ctx, student, _) {
              List<Student> _students = student.getStudents;
              return ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (BuildContext context, idx) {
                    return StudentNode(
                      id: _students[idx].id!,
                      title: "Student name: ${_students[idx].name}",
                      description: "Student age: ${_students[idx].age}",
                    );
                  });
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4e4e4e),
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => const AddStudentPage())),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
