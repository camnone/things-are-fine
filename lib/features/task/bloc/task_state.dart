part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskLoaded extends TaskState {
  const TaskLoaded({required this.tasks});

  final List<Task> tasks;

  @override
  List<Object> get props => super.props..add(tasks);
}

final class TaskFailure extends TaskState {
  const TaskFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
