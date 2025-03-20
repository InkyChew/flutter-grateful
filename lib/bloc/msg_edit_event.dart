part of 'msg_edit_bloc.dart';

sealed class MsgEditEvent extends Equatable {
  const MsgEditEvent();

  @override
  List<Object> get props => [];
}

class InitMsgEvent extends MsgEditEvent {
  final Msg msg;

  const InitMsgEvent(this.msg);
}

class UpdateMsgEvent extends MsgEditEvent {
  final Msg msg;

  const UpdateMsgEvent(this.msg);
}

class RemoveMsgEvent extends MsgEditEvent {
  final Msg msg;

  const RemoveMsgEvent(this.msg);
}
