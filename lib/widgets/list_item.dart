import 'package:flutter/material.dart';

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
      trailing: Container(
        // color: Colors.amber,
        width: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
            IconButton(
                onPressed: () => _removeOrDeleteTask(context, task),
                icon: Icon(
                  Icons.delete,
                  color: Color(0xFFFF7900),
                )),
          ],
        ),
      ),
    );
  }
}
