class ToDoModel {
  final String id;
  final String taskName;
  final String dueDate;
  final TodoCategories todoCategories;
  bool status;
  ToDoModel({
    required this.id,
    required this.taskName,
    required this.dueDate,
    required this.todoCategories,
    required this.status,
  });
}

enum TodoCategories {
  All,
  Pending,
  Shopping,
  Personal,
  Work,
  Wishlist,
  Finished
}
