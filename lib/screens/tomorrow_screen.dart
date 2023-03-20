// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/list_task.dart';

class TomorrowScreen extends StatefulWidget {
  List<Task> tomorrowTask;
  TomorrowScreen({
    super.key,
    required this.tomorrowTask,
  });

  @override
  State<TomorrowScreen> createState() => _TomorrowScreenState();
}

class _TomorrowScreenState extends State<TomorrowScreen> {
  void addNewTask({
    required String name,
    required DateTime createdTime,
    required String deadlineTime,
    required String description,
  }) {
    final newTask = Task(
      name: name,
      createdTime: createdTime,
      deadlineTime: deadlineTime,
      description: description,
    );

    setState(() {
      widget.tomorrowTask.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Today Tasks'),
      ),
      body: SizedBox(
        child: TaskList(
          taskList: widget.tomorrowTask,
          deleteItem: (int index) {
            setState(() {
              widget.tomorrowTask.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}
