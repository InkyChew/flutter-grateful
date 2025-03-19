part of 'msg_bloc.dart';

sealed class MsgEvent extends Equatable {
  const MsgEvent();

  @override
  List<Object> get props => [];
}

class GetMsgListEvent extends MsgEvent {
  final int? from;
  final int to;

  const GetMsgListEvent({this.from, required this.to});
}

class UpdateMsgEvent extends MsgEvent {
  final String text;
  final int from;
  final int to;
  final Privacy privacy;

  const UpdateMsgEvent({
    required this.text,
    required this.from,
    required this.to,
    required this.privacy,
  });
}

class RemoveMsgEvent extends MsgEvent {
  final Msg msg;

  const RemoveMsgEvent({required this.msg});
}
