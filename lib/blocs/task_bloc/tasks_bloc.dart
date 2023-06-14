import 'package:equatable/equatable.dart';
import '../../blocs/bloc_exports.dart';
import 'package:todo_bloc2/models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<RemoveTaskEvent>(_onRemoveTask);
    on<DeleteAllTask>(_onDeleteAllTask);
    on<IsfavoriteTaskEvent>(_onIsFavoriteTask);
    on<RestoreTaskEvent>(_onRestoreTask);
  }

  void _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        //add a new Task Object to the total taskList
        pendingTasks: List.from(state.pendingTasks)..add(event.task),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedtasks = state.completedTasks;

    task.isDone == false
        ? {
            pendingTasks = List.from(pendingTasks)..remove(task),
            completedtasks = List.from(completedtasks)
              ..insert(0, task.copyWith(isDone: true))
          }
        : {
            completedtasks = List.from(completedtasks)..remove(task),
            pendingTasks = List.from(pendingTasks)
              ..insert(0, task.copyWith(isDone: false))
          };

    emit(TasksState(
        removedTasks: state.removedTasks,
        completedTasks: completedtasks,
        favoriteTasks: state.favoriteTasks,
        pendingTasks: pendingTasks));
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks,
          removedTasks: List.from(state.removedTasks)..remove(event.task)),
    );
  }

  void _onRemoveTask(RemoveTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: List.from(state.pendingTasks)..remove(event.task),
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
          removedTasks: List.from(state.removedTasks)
            ..add(event.task.copyWith(isDeleted: true))),
    );
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) async {
    final state = this.state;

    emit(
      TasksState(
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks,
          removedTasks: const []),
    );
  }

  void _onIsFavoriteTask(
      IsfavoriteTaskEvent event, Emitter<TasksState> emit) async {
    final state = this.state;
    final task = event.task;

    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        var taskIndex = pendingTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));
        favoriteTasks.remove(task);
      }
    } else {
      if (task.isFavorite == false) {
        var taskIndex = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: true));
        favoriteTasks.insert(0, task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTasks.indexOf(task);
        completedTasks = List.from(completedTasks)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isFavorite: false));
        favoriteTasks.remove(task);
      }
    }

    emit(
      TasksState(
        pendingTasks: pendingTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks,
        removedTasks: state.removedTasks,
      ),
    );
  }

  void _onRestoreTask(RestoreTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;

    emit(
      TasksState(
        removedTasks: List.from(state.removedTasks)..remove(task),
        pendingTasks: List.from(state.pendingTasks)
          ..insert(
              0,
              task.copyWith(
                  isDeleted: false, isDone: false, isFavorite: false)),
        completedTasks: state.completedTasks,
        favoriteTasks: state.favoriteTasks,
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
