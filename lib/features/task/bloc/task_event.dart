part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class LoadTasks extends TaskEvent {}

final class ClearTask extends TaskEvent {}

final class SetTask extends TaskEvent {
  final Task task;

  const SetTask({required this.task});

  @override
  List<Object> get props => super.props..add(task);
}

final class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object> get props => super.props..add(task);
}

final class UpdateFavoriteStatusTask extends TaskEvent {
  final Task task;

  const UpdateFavoriteStatusTask({required this.task});
}

final class UpdateIsDoneStatusTask extends TaskEvent {
  final Task task;

  const UpdateIsDoneStatusTask({required this.task});
}
