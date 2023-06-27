import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:udemy_todo_provider/model/todo.dart';
import 'package:udemy_todo_provider/provider/todoprovider.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  final textcontroller = TextEditingController();

  Future dialogBilder() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Todo'),
            content: TextField(
              controller: textcontroller,
              decoration: InputDecoration(hintText: '할 일 입력'),
            ),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    if (textcontroller.text.isEmpty) {
                      return;
                    } else {
                      context.read<TodoProvider>().addTodo(
                          Todo(title: textcontroller.text, completed: false));
                    }
                    Navigator.pop(context);
                    textcontroller.clear();
                  },
                  child: Text('저장')),
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textcontroller.clear();
                  },
                  child: Text('취소'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialogBilder();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(
          child: Text('To do'),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: ListView.builder(
                itemCount: context.read<TodoProvider>().allTodoList.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading: MSHCheckbox(
                      size: 40,
                      value: provider.allTodoList[index].completed,
                      onChanged: (bool selected) {
                        provider.todosSatusChange(provider.allTodoList[index]);
                      },
                    ),
                    title: GestureDetector(
                      onTap: () {
                        provider.todosSatusChange(provider.allTodoList[index]);
                      },
                      child: Text(context
                          .read<TodoProvider>()
                          .allTodoList[index]
                          .title),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          provider.removeTodo(provider.allTodoList[index]);
                        },
                        icon: Icon(Icons.delete_forever)),
                  );
                })),
          ))
        ],
      )),
    );
  }
}
