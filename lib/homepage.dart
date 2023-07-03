import 'package:flutter/material.dart';
import 'package:todoapp/card.dart';
import 'package:todoapp/newtask.dart';
import 'package:todoapp/popuplist.dart';
import 'package:todoapp/todo_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addTodo(ToDoModel toDoModel) {
    listOfTodo.add(toDoModel);
    if (category == TodoCategories.All ||
        category == TodoCategories.Pending ||
        category == toDoModel.todoCategories) {
      _tempList.add(toDoModel);
    }
    setState(() {});
  }

  TodoCategories category = TodoCategories.Pending;

  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    if (category == TodoCategories.All) {
      _tempList = listOfTodo.toList();
    } else if (category == TodoCategories.Pending) {
      _tempList =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == TodoCategories.Finished) {
      _tempList =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      _tempList = listOfTodo
          .where((element) => element.todoCategories == category)
          .toList();
    }
    setState(() {});
  }

  List<ToDoModel> listOfTodo = [];
  List<ToDoModel> _tempList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTask(
                addTodo: addTodo,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("TODO: $category"),
        actions: [
          PopupMenuButton<TodoCategories>(
            onSelected: (value) {
              category = value;
              if (category == TodoCategories.All) {
                _tempList = listOfTodo.toList();
              } else if (category == TodoCategories.Pending) {
                _tempList = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == TodoCategories.Finished) {
                _tempList = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                _tempList = listOfTodo
                    .where((element) => element.todoCategories == value)
                    .toList();
              }
              setState(() {});
            },
            itemBuilder: (context) => popUpMenuItemTitleList
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(e.name),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: ListView(
        children: _tempList
            .map((e) => ToDoCard(
                  toDoModel: e,
                  update: updateStatus,
                ))
            .toList(),
      ),
    );
  }
}
