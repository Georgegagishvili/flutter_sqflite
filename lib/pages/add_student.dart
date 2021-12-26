import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_seven/logic/models/student.dart';
import 'package:task_seven/logic/providers/students_model.dart';
import 'package:task_seven/logic/services/students_db.dart';
import 'package:task_seven/widgets/default_appbar.dart';
import 'package:task_seven/widgets/default_textfield.dart';
import 'package:task_seven/widgets/primary_button.dart';

class _AddStudentPageState extends State<AddStudentPage> {
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map _fieldData = {
      "Student ID": _idController,
      "Student's name(*)": _nameController,
      "Students's age(*)": _ageController,
    };
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const DefaultAppBar(
          title: 'Add Student',
        ),
        body: Stack(
          children: [
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _fieldData.keys.length,
              itemBuilder: (BuildContext context, idx) {
                return DefaultTextField(
                  controller: _fieldData.values.toList()[idx],
                  label: _fieldData.keys.toList()[idx],
                  textInputType: idx != 1 ? TextInputType.number : null,
                );
              },
              separatorBuilder: (BuildContext context, _) {
                return const Divider(
                  height: 20,
                );
              },
            ),
            Positioned(
              right: 16,
              left: 16,
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: PrimaryButton(
                title: 'Add Student',
                action: () => _addStudent(),
              ),
            )
          ],
        ),
      ),
    );
  }

  _addStudent() async {
    final student = Student(
      id: _idController.text.isEmpty ? null : int.parse(_idController.text),
      age: int.parse(_ageController.text),
      name: _nameController.text,
    );
    await StudentsDatabase.instance.createOrUpdate(student);
    Provider.of<StudentsModel>(context, listen: false).loadStudents();
    Navigator.of(context).pop();
  }
}

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}
