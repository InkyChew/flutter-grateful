part of 'msg_list_bloc.dart';

sealed class MsgListState extends Equatable {
  const MsgListState();

  @override
  List<Object> get props => [];
}

final class MsgListInitial extends MsgListState {}

final class MsgListLoading extends MsgListState {}

final class MsgListLoaded extends MsgListState {
  final List<Msg> msgList;

  const MsgListLoaded(this.msgList);
}

final class MsgListError extends MsgListState {
  final String error;

  const MsgListError(this.error);
}
