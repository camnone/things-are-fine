part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class LoadHistory extends HistoryEvent {}

final class DeleteHistory extends HistoryEvent {
  final History history;

  const DeleteHistory({required this.history});
}

final class DeleteAllHistory extends HistoryEvent {}
