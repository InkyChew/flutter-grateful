part of 'msg_bloc.dart';

sealed class MsgState extends Equatable {
  const MsgState();

  @override
  List<Object> get props => [];
}

final class Initial extends MsgState {}

final class Loading extends MsgState {}

final class Error extends MsgState {
  final String error;

  const Error(this.error);
}

final class MsgListLoaded extends MsgState {
  final List<Msg> msgList;

  const MsgListLoaded(this.msgList);
}

final class MsgUpdated extends MsgState {}