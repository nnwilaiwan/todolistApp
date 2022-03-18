import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/provider/todo_list_provider.dart';
import 'package:todoapp/screens/new_item_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> list = <Todo>[];

  void goToNewItemView() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AddNewItemScreen();
      }),
    );
  }

  void goToEditItemView(Todo item) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AddNewItemScreen(
          item: item,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TO DO APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, provider, child) {
          return provider.items.isNotEmpty
              ? ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: ((context, index) {
                    return TodoItem(
                        item: provider.items[index],
                        onTap: provider.changeCompleteness,
                        onDismissed: provider.removeItem,
                        onLongPress: goToEditItemView);
                  }),
                )
              : const Center(
                  child: Text(
                    'No Item',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          goToNewItemView();
        },
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo item;
  final Function(Todo) onTap;
  final Function(Todo) onLongPress;
  final Function(Todo) onDismissed;

  TodoItem(
      {required this.item,
      required this.onTap,
      required this.onDismissed,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.hashCode.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(left: 12),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
      ),
      onDismissed: (direction) => onDismissed(item),
      child: ListTile(
        title: Text(
          item.description,
          style: TextStyle(
            decoration: item.complete ? TextDecoration.lineThrough : null,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          item.complete ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onTap: () => onTap(item),
        onLongPress: () => onLongPress(item),
      ),
    );
  }
}
