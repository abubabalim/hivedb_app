import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivedb_app/main.dart';
import 'package:hivedb_app/screens/add_todo_screen.dart';

import '../adapter/Todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Box<Todo> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<Todo>(boxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: _myBox.listenable(),
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Center(child: Text('Todo Tidak Ada'),);
          }
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              // GET TODO AT INDEX
              log(value.length.toString());
              Todo todo = value.getAt(index);
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  // DELETE TODO AT INDEX
                  _myBox.deleteAt(index);
                },
                child: ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
