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
class SetalarmEvent extends TasksEvent {
  final Task task;

  const SetalarmEvent({required this.task});
  @override
  List<Object> get props => [task];
}

// //Adds a task to favoriteTasks list!!
// class IsfavoriteTaskEvent extends TasksEvent {
//   final Task task;

//   const IsfavoriteTaskEvent({required this.task});
//   @override
//   List<Object> get props => [task];
// }

//restore the task from Recycle Bin!!
class RestoreTaskEvent extends TasksEvent {
  final Task task;

  const RestoreTaskEvent({required this.task});
  @override
  List<Object> get props => [task];
}

//Edit tasks!!
class EditTaskEvent extends TasksEvent {
  final Task oldTask;
  final Task newTask;

  const EditTaskEvent({required this.oldTask, required this.newTask});
  @override
  List<Object> get props => [oldTask, newTask];
}

//Delete All tasks from RemovedList!!
class DeleteAllTask extends TasksEvent {}
