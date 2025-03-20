part of 'msg_list_bloc.dart';

sealed class MsgListEvent extends Equatable {
  const MsgListEvent();

  @override
  List<Object> get props => [];
}

class GetMsgListEvent extends MsgListEvent {
  final int? from;
  final int to;

  const GetMsgListEvent({this.from, required this.to});
}
