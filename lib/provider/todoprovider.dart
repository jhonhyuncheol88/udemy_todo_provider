import 'package:flutter/material.dart';
import 'package:udemy_todo_provider/model/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> todos = [];
  List<Todo> get allTodoList => todos;

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  void todosSatusChange(Todo todo) {
    final index = todos.indexOf(todo);
    todos[index].togglecompleted();
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    final index = todos.indexOf(todo);
    todos.removeAt(index);
    notifyListeners();
  }
}
