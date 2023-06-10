import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bloc/bloc_exports.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 10),
                color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.10,
                width: double.infinity,
                child: const Text(
                  'Hi Dear Friend',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Task'),
                trailing: Text('${state.allTasks.length}'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Recycle Bin'),
                trailing: Text('0'),
              )
            ],
          );
        },
      ),
    );
  }
}
