// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/list_task.dart';

class TodayScreen extends StatefulWidget {
  List<Task> todayTask;
  TodayScreen({
    super.key,
    required this.todayTask,
  });

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
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
      widget.todayTask.add(newTask);
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
          taskList: widget.todayTask,
          deleteItem: (int index) {
            setState(() {
              widget.todayTask.removeAt(index);
            });
          },
          showMore: (index) => {
            showGeneralDialog(
              context: context,
              barrierLabel: "Barrier",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) {
                return Center(
                  child: SizedBox(
                    height: 450,
                    child: Card(
                      margin: EdgeInsets.all(20),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Name: ${widget.todayTask[index].name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Created Time: ${widget.todayTask[index].createdTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Deadline Time: ${widget.todayTask[index].deadlineTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Description: ${widget.todayTask[index].description}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            SizedBox(
                              height: 20,
                            ),
                            FloatingActionButton.extended(
                              label: Row(
                                children: const <Widget>[
                                  Text("Close"),
                                  Icon(Icons.close),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              extendedTextStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          },
        ),
      ),
    );
  }
}
