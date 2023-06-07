import 'package:flutter/material.dart';
import 'package:todo_bloc2/models/task.dart';

class TaskScreen extends StatelessWidget {
  TaskScreen({super.key});
  List<Task> taskList = [
    Task(title: 'task1'),
    Task(title: 'task2'),
    Task(title: 'task3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
        actions: [Icon(Icons.add)],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, i) {
                  final task = taskList[i];
                  return ListTile(
                    title: Text(task.title),
                    trailing: Checkbox(value: task.isDone, onChanged: (val) {}),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
