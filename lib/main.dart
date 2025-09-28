import 'package:flutter/material.dart';
import 'components/todohomepage.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}