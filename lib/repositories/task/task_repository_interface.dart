import 'package:thingsarefine/repositories/task/models/task.dart';

abstract interface class TaskRepositoryInterface {
  Future<List<Task>> getTasks();
  Future<void> setTasks(Task task);
  Future<void> clearTask(Task task);
  Future<void> updateFavoriteStatusTask(Task task);
  Future<void> updateIsDoneStatusTask(Task task);
}
