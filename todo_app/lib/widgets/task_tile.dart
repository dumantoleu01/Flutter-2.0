import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTile;
  final Function checkboxCall;
  final Function longPressCallBack;

  const TaskTile({
    Key? key,
    required this.taskTile,
    required this.isChecked,
    required this.checkboxCall,
    required this.longPressCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () => longPressCallBack(),
      title: Text(
        taskTile,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        activeColor: Colors.lightBlueAccent,
        value: isChecked,
        onChanged: (newValue) {
          checkboxCall(newValue);
        },
      ),
    );
  }
}

// (bool? checkboxState) {
//           setState(() {
//             isChecked = checkboxState;
//           });
//         },

