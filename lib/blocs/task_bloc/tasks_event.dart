part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

//Adds the Tasks to the allTasks!!
class AddTask extends TasksEvent {
  final Task task;

  const AddTask({required this.task});
  @override
  List<Object> get props => [task];
}

//Marks Events as Done or UnDone!!
class UpdateTask extends TasksEvent {
  final Task task;

  const UpdateTask({required this.task});
  @override
  List<Object> get props => [task];
}

//Adds the Tasks to the RemovedList!!
class RemoveTask extends TasksEvent {
  final Task task;

  const RemoveTask({required this.task});
  @override
  List<Object> get props => [task];
}

//Delete selected tasks from RemovedList!!
class DeleteTask extends TasksEvent {
  final Task task;

  const DeleteTask({required this.task});
  @override
  List<Object> get props => [task];
}
