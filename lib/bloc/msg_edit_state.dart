part of 'msg_edit_bloc.dart';

sealed class MsgEditState {}

final class MsgEditInitial extends MsgEditState {}

final class MsgEditLoading extends MsgEditState {}

final class MsgEditSuccess extends MsgEditState {
  final Msg msg;

  MsgEditSuccess(this.msg);
}

final class MsgEditError extends MsgEditState {
  final String error;

  MsgEditError(this.error);
}
