import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_bloc2/widgets/pop_up_menu.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: task.isFavorite == false
          ? Icon(Icons.star_border)
          : Icon(
              Icons.star,
              color: Colors.orange,
            ),
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(DateFormat('MMM dd, yyyy - HH:mm')
          .format(DateTime.parse(task.regDate))),
      trailing: Container(
        // color: Colors.amber,
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all(
                  Theme.of(context).appBarTheme.backgroundColor),
              value: task.isDone,
              onChanged: (val) {
                context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
              },
            ),
            PopUpMenu(
              task: task,
            ),
          ],
        ),
      ),
    );
  }
}
