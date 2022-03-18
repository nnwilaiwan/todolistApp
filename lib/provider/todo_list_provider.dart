import 'package:flutter/foundation.dart';
import 'package:todoapp/model/todo.dart';

class TodoListProvider with ChangeNotifier {
  // List<Todo> items = List<Todo>.empty(growable: true);
  List<Todo> items = [
    // Todo(description: 'Item 1'),
    // Todo(description: 'Item 2'),
    // Todo(description: 'Item test'),
    // Todo(description: 'Item 4'),
  ];

  void editTask(Todo item, String description) {
    if (description.isNotEmpty && description != '') {
      item.description = description;
      notifyListeners();
    }
  }

  void removeItem(Todo item) {
    items.remove(item);
    notifyListeners();
  }

  void addNewTask(String description) {
    if (description.isNotEmpty && description != '') {
      items.add(Todo(description: description));
      notifyListeners();
    }
  }

  void changeCompleteness(Todo item) {
    item.complete = !item.complete;
    notifyListeners();
  }
}
