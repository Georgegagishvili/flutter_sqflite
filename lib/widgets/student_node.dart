import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_seven/logic/providers/students_model.dart';
import 'package:task_seven/logic/services/students_db.dart';

class StudentNode extends StatelessWidget {
  const StudentNode({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff1D4350),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(3),
          color: Colors.transparent),
      child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () => _deleteStudent(context),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  )),
              CircleAvatar(
                backgroundColor: Colors.grey[700],
                child: Text(
                  "$id",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }

  _deleteStudent(context) async {
    await StudentsDatabase.instance.delete(id);
    Provider.of<StudentsModel>(context, listen: false).loadStudents();
  }
}
