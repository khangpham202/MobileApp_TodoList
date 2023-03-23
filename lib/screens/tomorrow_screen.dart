// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late final List<Task> tomorrowTask;
  @override
  void initState() {
    tomorrowTask = widget.tomorrowTask;
    super.initState();
  }

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
      tomorrowTask.add(newTask);
    });
  }

  void updateTask({
    required String name,
    required DateTime createdTime,
    required String deadlineTime,
    required String description,
    required int index,
  }) {
    final currentTask = Task(
      name: name,
      createdTime: createdTime,
      deadlineTime: deadlineTime,
      description: description,
    );

    setState(() {
      tomorrowTask[index] = currentTask;
    });
  }

  TextEditingController newNameController = TextEditingController();

  TextEditingController newDeadlineTimeController = TextEditingController();

  TextEditingController newDescriptionController = TextEditingController();

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
                              "Name: ${widget.tomorrowTask[index].name}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Created Time: ${widget.tomorrowTask[index].createdTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Deadline Time: ${widget.tomorrowTask[index].deadlineTime}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(),
                            Text(
                              "Description: ${widget.tomorrowTask[index].description}",
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
            ),
          },
          editItem: (index) => {
            showGeneralDialog(
              context: context,
              barrierLabel: "Barrier",
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: Duration(milliseconds: 700),
              pageBuilder: (_, __, ___) {
                final Task item = tomorrowTask[index];
                newNameController.text = item.name;
                newDeadlineTimeController.text = item.deadlineTime;
                newDescriptionController.text = item.description;

                return Center(
                  child: SizedBox(
                    height: 600,
                    child: Card(
                      margin: EdgeInsets.all(20),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Name of task'),
                              controller: newNameController,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Deadline Time'),
                              controller: newDeadlineTimeController,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    newDeadlineTimeController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                  //set output date to TextField value.
                                }
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Description'),
                              controller: newDescriptionController,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                FloatingActionButton.extended(
                                  label: Row(
                                    children: const [
                                      Text("Close"),
                                      Icon(Icons.close),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  extendedTextStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  backgroundColor: Colors.green,
                                ),
                                FloatingActionButton.extended(
                                  label: Row(
                                    children: const [
                                      Text("Confirm"),
                                      Icon(Icons.check),
                                    ],
                                  ),
                                  onPressed: () {
                                    updateTask(
                                      name: newNameController.text,
                                      createdTime: DateTime.now(),
                                      deadlineTime:
                                          newDeadlineTimeController.text,
                                      description:
                                          newDescriptionController.text,
                                      index: index,
                                    );
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Update Successfully !',
                                          textAlign: TextAlign.center,
                                        ),
                                        backgroundColor: Colors.teal,
                                      ),
                                    );
                                  },
                                  extendedTextStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
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
