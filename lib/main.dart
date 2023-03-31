import 'package:flutter/material.dart';
import 'package:todo_app/todo_app/todo_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeLayout(),
    );
  }
}
