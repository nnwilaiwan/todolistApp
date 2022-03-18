import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/provider/todo_list_provider.dart';

class AddNewItemScreen extends StatefulWidget {
  final Todo? item;

  AddNewItemScreen({this.item});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  TextEditingController textFieldController = TextEditingController();

  void submit() {
    String description = textFieldController.text;
    if (description.isNotEmpty) {
      if (widget.item != null) {
        context.read<TodoListProvider>().editTask(widget.item!, description);
      } else {
        context.read<TodoListProvider>().addNewTask(description);
      }
      Navigator.pop(context, textFieldController.text);
    }
  }

  @override
  void initState() {
    if (widget.item != null) {
      textFieldController.text = widget.item!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New List',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: textFieldController,
              onFieldSubmitted: (value) {
                submit();
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 10),
            RaisedButton(
              color: Colors.green,
              onPressed: () {
                submit();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
