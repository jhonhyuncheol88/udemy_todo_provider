import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_todo_provider/provider/todoprovider.dart';
import 'package:udemy_todo_provider/screen/TodosPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TodoProvider())],
      child: MaterialApp(
        title: "Todos",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.blue),
        home: TodosPage(),
      ),
    );
  }
}
