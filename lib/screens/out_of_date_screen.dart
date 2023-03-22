import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/list_task.dart';

class OutOfDateScreen extends StatefulWidget {
  List<Task> outOfDateTask;
  OutOfDateScreen({
    super.key,
    required this.outOfDateTask,
  });

  @override
  State<OutOfDateScreen> createState() => _OutOfDateScreenState();
}

class _OutOfDateScreenState extends State<OutOfDateScreen> {
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
      widget.outOfDateTask.add(newTask);
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
          taskList: widget.outOfDateTask,
          deleteItem: (int index) {
            setState(() {
              widget.outOfDateTask.removeAt(index);
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
                              "Name: ${widget.outOfDateTask[index].name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Created Time: ${widget.outOfDateTask[index].createdTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Deadline Time: ${widget.outOfDateTask[index].deadlineTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Description: ${widget.outOfDateTask[index].description}",
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
