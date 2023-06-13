// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:todo_bloc2/models/task.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
    required this.cancelOrDeleteCallBack,
    required this.isFavoriteCallBack,
    required this.task,
  }) : super(key: key);

  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback isFavoriteCallBack;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return task.isDeleted == false
        ? PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    isFavoriteCallBack();
                    Navigator.of(context).pop();
                  },
                  icon: task.isFavorite == false
                      ? const Icon(Icons.bookmark_add_outlined)
                      : const Icon(Icons.bookmark_add),
                  label: task.isFavorite == false
                      ? const Text('Save')
                      : const Text('Saved'),
                ),
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    cancelOrDeleteCallBack();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
            ],
          )
        : PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {},
                  icon: const Icon(Icons.undo),
                  label: const Text('Restore'),
                ),
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: cancelOrDeleteCallBack,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Delete Forever'),
                ),
              ),
            ],
          );
  }
}
