import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModaLInputField extends StatefulWidget {
  const ModaLInputField({super.key, required this.addTask});
  final Function({
    required String name,
    required DateTime createdTime,
    required String deadlineTime,
    required String description,
  }) addTask;
  @override
  State<ModaLInputField> createState() => _ModaLInputFieldState();
}

class _ModaLInputFieldState extends State<ModaLInputField> {
  final nameController = TextEditingController();

  final deadlineTimeController = TextEditingController();

  final descriptionController = TextEditingController();

  @override
  void initState() {
    deadlineTimeController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Name of task'),
              controller: nameController,
            ),
            TextField(
              controller: deadlineTimeController,
              decoration: const InputDecoration(labelText: 'Deadline Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    deadlineTimeController.text =
                        formattedDate; //set output date to TextField value.
                  });
                  //set output date to TextField value.
                }
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              controller: descriptionController,
            ),
            SizedBox(
              height: 17,
            ),
            FloatingActionButton(
              backgroundColor: Color.fromARGB(209, 218, 46, 46),
              onPressed: () {
                widget.addTask(
                  name: nameController.text,
                  createdTime: DateTime.now(),
                  deadlineTime: deadlineTimeController.text,
                  description: descriptionController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
