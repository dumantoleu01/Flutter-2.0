import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_data.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskdata, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TaskTile(
              taskTile: taskdata.getName(index),
              isChecked: taskdata.getIsDone(index),
              checkboxCall: (checkboxState) {
                taskdata.updateTask(index);
              },
              longPressCallBack: () {
                taskdata.deleteTask(index);
                // print("Deleted");
              },
            );
          },
          itemCount: Provider.of<TaskData>(context).taskCount,
        );
      },
    );
  }
}
