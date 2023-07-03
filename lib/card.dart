import 'package:flutter/material.dart';
import 'package:todoapp/todo_model.dart';

class ToDoCard extends StatelessWidget {
  final ToDoModel toDoModel;
  final Function(String, bool) update;
  const ToDoCard({super.key, required this.toDoModel, required this.update});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            print(value);
            update(toDoModel.id, value!);
          },
          value: toDoModel.status,
        ),
        title: Text(toDoModel.taskName),
        subtitle: Text(toDoModel.dueDate),
        trailing: Text(
          toDoModel.todoCategories.name,
          style: TextStyle(
              color: todoTypeColor(toDoModel.todoCategories),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

Color todoTypeColor(TodoCategories value) {
  switch (value) {
    case TodoCategories.Shopping:
      return Colors.purple;
    case TodoCategories.Work:
      return Colors.blue;
    case TodoCategories.Personal:
      return Colors.red;
    case TodoCategories.Wishlist:
      return Colors.orange;
    default:
      return Colors.black;
  }
}
