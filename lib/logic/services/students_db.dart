import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_seven/logic/models/student.dart';

class StudentsDatabase {
  static final StudentsDatabase instance = StudentsDatabase._init();

  static Database? _database;

  StudentsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('students.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const ageType = 'INTEGER NOT NULL';
    const nameType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableStudents (
    ${StudentFields.id} $idType,
    ${StudentFields.name} $nameType,
    ${StudentFields.age} $ageType
    )
    ''');
  }

  Future<Student> createOrUpdate(Student student) async {
    final db = await instance.database;
    await db.insert(tableStudents, student.toJson());

    return student;
  }

  Future<List<Student>> readAllStudents() async {
    final db = await instance.database;
    final res =
        await db.query(tableStudents, orderBy: '${StudentFields.id} ASC');

    return res.map((json) => Student.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(tableStudents,
        where: "${StudentFields.id} = ?", whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
