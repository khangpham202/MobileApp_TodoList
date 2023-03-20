// import 'package:flutter/material.dart';

// class OutOfDateScreen extends StatefulWidget {
//   const OutOfDateScreen({super.key});

//   @override
//   State<OutOfDateScreen> createState() => _OutOfDateScreenState();
// }

// class _OutOfDateScreenState extends State<OutOfDateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: must_be_immutable

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
        ),
      ),
    );
  }
}
