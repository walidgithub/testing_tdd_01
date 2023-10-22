part of 'task_cubit.dart';

// The sealed modifier prevents a class from being extended or implemented outside its own library.
sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskUpdated extends TaskState {
final List<Task> tasks;

const TaskUpdated({required this.tasks});

@override
List<Object> get props => [...super.props, tasks];
}