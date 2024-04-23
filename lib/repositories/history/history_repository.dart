import 'package:thingsarefine/repositories/history/history_repository_interface.dart';
import 'package:thingsarefine/repositories/history/models/history.dart';
import 'package:realm/realm.dart';

class HistoryRepository implements HistoryRepositoryInterface {
  final Realm realm;

  HistoryRepository({required this.realm});
  @override
  Future<List<History>> getHistory() async {
    return realm.all<History>().toList();
  }

  @override
  Future<void> addHistory(History history) async {
    final _history = realm.query<History>(
      "id == '${history.id}'",
    );
    if (_history.isNotEmpty) {
      for (var e in _history) {
        realm.write(() => realm.delete(e));
      }
      return;
    }
    realm.write(() => realm.add(history));
  }

  @override
  Future<void> deleteHistory(History history) async {
    realm.write(() => realm.delete(history));
  }

  @override
  Future<void> deleteAllHistory() async {
    realm.write(() => realm.deleteAll<History>());
  }
}
