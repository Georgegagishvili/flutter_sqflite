import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_seven/pages/home.dart';
import 'logic/providers/students_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      child: MaterialApp(
        title: 'Flutter Sqflite',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xffececec)),
        home: const HomePage(),
      ),
      create: (BuildContext context) => StudentsModel(),
    );
  }
}
