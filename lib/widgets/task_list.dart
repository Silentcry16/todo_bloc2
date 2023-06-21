import 'package:flutter/material.dart';
import 'package:todo_bloc2/widgets/app_text.dart';
import '../blocs/bloc_exports.dart';
import '../models/task.dart';
import 'edit_task.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.taskList,
  });

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<SwitchBloc, SwitchState>(
      builder: (context, state) {
        return Expanded(
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              height: size.height * 0.74,
              margin: EdgeInsets.all(size.width * 0.02),
              child: GridView.builder(
                itemCount: taskList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: size.height * 0.02,
                    mainAxisSpacing: size.height * 0.02,
                    mainAxisExtent: 195),
                itemBuilder: (context, i) {
                  var task = taskList[i];
                  return Container(
                    margin: const EdgeInsets.only(top: 9, bottom: 9),
                    decoration: BoxDecoration(
                      color:
                          state.switchValue ? Colors.grey.shade700 : task.color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(size.height * 0.03),
                        bottomLeft: Radius.circular(size.height * 0.03),
                        bottomRight: Radius.circular(size.height * 0.03),
                        topRight: Radius.circular(size.height * 0.03),
                      ),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.black26,
                            offset: Offset(2, 2)),
                      ],
                    ),
                    width: size.width / 2,
                    child: Column(
                      children: [
                        //ListTile Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                task.isDeleted == true
                                    ? context
                                        .read<TasksBloc>()
                                        .add(DeleteTaskEvent(task: task))
                                    : context
                                        .read<TasksBloc>()
                                        .add(RemoveTaskEvent(task: task));
                              },
                              icon: const Icon(Icons.close),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                task.isDeleted == true
                                    ? context
                                        .read<TasksBloc>()
                                        .add(RestoreTaskEvent(task: task))
                                    : showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: EditTask(
                                                  oldtask: task,
                                                )),
                                          );
                                        },
                                      );
                              },
                              icon: task.isDeleted == true
                                  ? const Icon(Icons.restart_alt)
                                  : const Icon(Icons.edit),
                            ),
                            task.isDeleted == false
                                ? IconButton(
                                    onPressed: () => context
                                        .read<TasksBloc>()
                                        .add(UpdateTaskEvent(task: task)),
                                    icon: task.isDone == true
                                        ? const Icon(Icons.check_box_outlined)
                                        : const Icon(
                                            Icons.check_box_outline_blank),
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 5),
                        //registerationdate
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppText(
                            text: task.regDate,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.black45,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppText(
                            text: task.title,
                            size: 20,
                            overflow: TextOverflow.ellipsis,
                            weight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(size.height * 0.03),
                                  bottomRight:
                                      Radius.circular(size.height * 0.03),
                                )),
                            width: size.width,
                            height: size.height * 0.05,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: 'More',
                                  size: size.height * 0.025,
                                  color: state.switchValue
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
