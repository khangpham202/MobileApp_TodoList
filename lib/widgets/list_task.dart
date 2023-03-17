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
    return Center(
      child: DataTable(
        columnSpacing: 30.0,
        columns: _buildHeader(),
        rows: _buildBodyTable(),
      ),
    );
  }

  List<DataRow> _buildBodyTable() {
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
            IconButton(
              onPressed: () {
                print(taskList[index].createdTime);
                print(taskList[index].deadlineTime);
              },
              icon: Icon(
                Icons.format_align_justify_rounded,
              ),
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
