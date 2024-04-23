import 'dart:developer';

import 'package:thingsarefine/repositories/history/history_repository_interface.dart';
import 'package:thingsarefine/repositories/history/models/history.dart';
import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:thingsarefine/repositories/task/task_repository_interface.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepositoryInterface _taskRepository;
  final HistoryRepositoryInterface _historyRepository;

  TaskBloc(
      {required TaskRepositoryInterface taskRepository,
      required HistoryRepositoryInterface historyRepository})
      : _taskRepository = taskRepository,
        _historyRepository = historyRepository,
        super(TaskInitial()) {
    on<LoadTasks>(_load);
    on<SetTask>(_set);
    on<DeleteTask>(_delete);
    on<UpdateFavoriteStatusTask>(_updateFavoriteStatus);
    on<UpdateIsDoneStatusTask>(_updateIsDoneStatus);
  }

  Future<void> _load(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      emit(TaskLoading());
      final tasks = await _taskRepository.getTasks();
      emit(TaskLoaded(tasks: tasks));
    } catch (e) {
      emit(TaskFailure(e));
    }
  }

  Future<void> _set(SetTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.setTasks(event.task);
      add(LoadTasks());
    } catch (e) {
      log(e.toString());
      emit(TaskFailure(e));
    }
  }

  Future<void> _delete(DeleteTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.clearTask(event.task);
      add(LoadTasks());
    } catch (e) {
      log(e.toString());
      emit(TaskFailure(e));
    }
  }

  Future<void> _updateFavoriteStatus(
      UpdateFavoriteStatusTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateFavoriteStatusTask(event.task);
      add(LoadTasks());
    } catch (e) {
      log(e.toString());
      emit(TaskFailure(e));
    }
  }

  Future<void> _updateIsDoneStatus(
      UpdateIsDoneStatusTask event, Emitter<TaskState> emit) async {
    try {
      await _taskRepository.updateIsDoneStatusTask(event.task);
      if (event.task.isDone) {
        await _historyRepository.addHistory(
          History(
              event.task.id.toString(),
              event.task.title,
              event.task.description,
              event.task.createdAtTime,
              event.task.createdAtDate,
              event.task.isDone,
              event.task.isFavorite,
              event.task.category,
              event.task.categoryColor),
        );
      }
      add(LoadTasks());
    } catch (e) {
      log(e.toString());
      emit(TaskFailure(e));
    }
  }
}
