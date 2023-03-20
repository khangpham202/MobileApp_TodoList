import 'package:flutter/material.dart';
import '../models/task_model.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;
  final Function(int index) deleteItem;
  const TaskList({
    required this.taskList,
    required this.deleteItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 100),
      child: DataTable(
        columnSpacing: 30.0,
        columns: _buildHeader(),
        rows: _buildBodyTable(context),
      ),
    );
  }

  List<DataRow> _buildBodyTable(context) {
    return List<DataRow>.generate(
      taskList.length,
      (index) => DataRow(
        cells: [
          DataCell(Text(
            "${index + 1}",
          )),
          DataCell(
            Text(
              taskList[index].name,
            ),
          ),
          DataCell(
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Show more"),
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Delete"),
                ),
              ],
              onSelected: (int value) {
                (value == 2) ? taskList.removeAt(index) : print("123");
              },
              position: PopupMenuPosition.under,
            ),
          ),
        ],
      ),
    ).toList();
  }

  List<DataColumn> _buildHeader() {
    return const [
      DataColumn(
        label: Text('Number'),
      ),
      DataColumn(
        label: Text('Name'),
      ),
      DataColumn(
        label: Text('Modify'),
      ),
    ];
  }
}
