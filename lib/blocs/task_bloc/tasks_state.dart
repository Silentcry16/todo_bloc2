// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTasks;
  final List<Task> completedTasks;
  final DateTime? alarmTime;
  // final List<Task> favoriteTasks;
  final List<Task> removedTasks;
  const TasksState({
    this.alarmTime,
    this.pendingTasks = const <Task>[],
    this.completedTasks = const <Task>[],
    // this.favoriteTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  @override
  List<Object> get props => [pendingTasks, removedTasks];

// toMap() and fromMap() are responsible for converting
//the state object to a map representation and reconstructing the state
//object from a map, respectively.

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTasks': pendingTasks.map((x) => x.toMap()).toList(),
      'completedTasks': completedTasks.map((x) => x.toMap()).toList(),
      'alarmTime': alarmTime?.millisecondsSinceEpoch,
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      pendingTasks: List<Task>.from(
        (map['pendingTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      completedTasks: List<Task>.from(
        (map['completedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
      alarmTime: map['alarmTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['alarmTime'] as int)
          : null,
      removedTasks: List<Task>.from(
        (map['removedTasks'] as List<int>).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
