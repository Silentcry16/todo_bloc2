part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

//Adds the Tasks to the allTasks!!
class AddTaskEvent extends TasksEvent {
  final Task task;

  const AddTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Marks Events as Done or UnDone!!
class UpdateTaskEvent extends TasksEvent {
  final Task task;

  const UpdateTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Adds the Tasks to the RemovedList!!
class RemoveTaskEvent extends TasksEvent {
  final Task task;

  const RemoveTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Delete selected tasks from RemovedList!!
class DeleteTaskEvent extends TasksEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Delete selected tasks from RemovedList!!
class isfavoriteTaskEvent extends TasksEvent {
  final Task task;

  const isfavoriteTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Delete All tasks from RemovedList!!
class DeleteAllTask extends TasksEvent {}
