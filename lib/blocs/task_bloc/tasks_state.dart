part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final List<Task> removedTasks;

  const TasksState({
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  @override
  List<Object> get props => [pendingTasks, completedTasks, removedTasks];

// toMap() and fromMap() are responsible for converting
//the state object to a map representation and reconstructing the state
//object from a map, respectively.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks']).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks']).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      removedTasks: List<Task>.from(
        (map['removedTasks']).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
