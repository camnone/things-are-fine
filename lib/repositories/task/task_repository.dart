import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:thingsarefine/repositories/task/task_repository_interface.dart';
import 'package:realm/realm.dart';

class TaskRepository implements TaskRepositoryInterface {
  TaskRepository({required this.realm});

  final Realm realm;

  @override
  Future<List<Task>> getTasks() async {
    return realm.all<Task>().toList();
  }

  @override
  Future<void> setTasks(Task task) async {
    realm.write(() => realm.add(task));
  }

  @override
  Future<void> clearTask(Task task) async {
    realm.write(() => realm.delete(task));
  }

  @override
  Future<void> updateFavoriteStatusTask(Task task) async {
    realm.write(() {
      task.isFavorite = !task.isFavorite;
      realm.add(task);
    });
  }

  @override
  Future<void> updateIsDoneStatusTask(Task task) async {
    realm.write(() {
      task.isDone = !task.isDone;
      realm.add(task);
    });
  }
}
