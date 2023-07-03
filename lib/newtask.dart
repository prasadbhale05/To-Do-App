import 'package:flutter/material.dart';
import 'package:todoapp/todo_model.dart';

class NewTask extends StatefulWidget {
  final Function(ToDoModel) addTodo;
  const NewTask({super.key, required this.addTodo});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  TodoCategories dropDownValue = TodoCategories.Work;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addTodo(ToDoModel(
              id: DateTime.now().toString(),
              taskName: taskController.text,
              dueDate: dueDateController.text,
              todoCategories: dropDownValue,
              status: false));
          Navigator.pop(context);
        },
        child: Icon(Icons.check),
      ),
      appBar: AppBar(
        title: const Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is to be done?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: "Enter your task.",
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Due Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            Row(
              children: [
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: dueDateController,
                    decoration: const InputDecoration(
                      hintText: "Date not set",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    dueDateController.text = date.toString().substring(0, 10);
                  },
                  icon: const Icon(Icons.calendar_month),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Add to list",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            DropdownButton<TodoCategories>(
              isExpanded: true,
              value: dropDownValue,
              items: const [
                DropdownMenuItem(
                  value: TodoCategories.Shopping,
                  child: Text("Shopping"),
                ),
                DropdownMenuItem(
                  value: TodoCategories.Personal,
                  child: Text("Personal"),
                ),
                DropdownMenuItem(
                  value: TodoCategories.Wishlist,
                  child: Text("Wishlist"),
                ),
                DropdownMenuItem(
                  value: TodoCategories.Work,
                  child: Text("Work"),
                ),
              ],
              onChanged: (value) {
                dropDownValue = value!;
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
