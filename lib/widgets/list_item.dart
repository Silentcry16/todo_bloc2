import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
          fillColor: MaterialStateProperty.all(Color(0xFFFF9E00)),
          value: task.isDone,
          onChanged: (val) {
            context.read<TasksBloc>().add(UpdateTask(task: task));
          }),
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(DateFormat.yMMMd().format(DateTime.parse(task.regDate))),
      trailing: Container(
        // color: Colors.amber,
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.star_border_rounded)),
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {},
                    icon: Icon(Icons.edit),
                    label: Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {},
                    icon: Icon(Icons.bookmark),
                    label: Text('Add to Bookmark'),
                  ),
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black)),
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    label: Text('Delete'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
