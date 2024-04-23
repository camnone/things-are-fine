import 'package:thingsarefine/repositories/history/history_repository_interface.dart';
import 'package:thingsarefine/repositories/history/models/history.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepositoryInterface _historyRepository;
  HistoryBloc({required HistoryRepositoryInterface historyRepository})
      : _historyRepository = historyRepository,
        super(HistoryInitial()) {
    on<LoadHistory>(_load);
    on<DeleteHistory>(_delete);
    on<DeleteAllHistory>(_deleteAll);
  }

  Future<void> _load(LoadHistory event, Emitter<HistoryState> emit) async {
    try {
      emit(HistoryLoading());
      final history = await _historyRepository.getHistory();
      emit(HistoryLoaded(history: history));
    } catch (e) {
      emit(HistoryFailure(e));
    }
  }

  Future<void> _delete(DeleteHistory event, Emitter<HistoryState> emit) async {
    try {
      await _historyRepository.deleteHistory(event.history);
      add(LoadHistory());
    } catch (e) {
      emit(HistoryFailure(e));
    }
  }

  Future<void> _deleteAll(
      DeleteAllHistory event, Emitter<HistoryState> emit) async {
    try {
      await _historyRepository.deleteAllHistory();
      add(LoadHistory());
    } catch (e) {
      emit(HistoryFailure(e));
    }
  }
}
