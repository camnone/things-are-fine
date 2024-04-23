import 'package:thingsarefine/repositories/history/models/history.dart';

abstract interface class HistoryRepositoryInterface {
  Future<List<History>> getHistory();
  Future<void> addHistory(History history);
  Future<void> deleteHistory(History history);
  Future<void> deleteAllHistory();
}
