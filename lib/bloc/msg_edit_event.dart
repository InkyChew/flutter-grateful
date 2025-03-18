part of 'msg_edit_bloc.dart';

sealed class MsgEditEvent {}

class SubmitMsgEvent extends MsgEditEvent {
  final String text;
  final int from;
  final int to;
  final Privacy privacy;

  SubmitMsgEvent({
    required this.text,
    required this.from,
    required this.to,
    required this.privacy,
  });
}