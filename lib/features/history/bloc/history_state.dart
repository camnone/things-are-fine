part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

final class HistoryInitial extends HistoryState {}

final class HistoryLoading extends HistoryState {}

final class HistoryLoaded extends HistoryState {
  const HistoryLoaded({required this.history});

  final List<History> history;

  @override
  List<Object> get props => super.props..add(history);
}

final class HistoryFailure extends HistoryState {
  const HistoryFailure(this.error);
  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
