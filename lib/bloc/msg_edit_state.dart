part of 'msg_edit_bloc.dart';

sealed class MsgEditState extends Equatable {
  const MsgEditState();

  @override
  List<Object> get props => [];
}

final class MsgEditInitial extends MsgEditState {
  final Msg msg;
  const MsgEditInitial(this.msg);
}

final class MsgEditLoading extends MsgEditState {}

final class MsgEditSuccess extends MsgEditState {}

final class MsgEditError extends MsgEditState {
  final String error;

  const MsgEditError(this.error);
}
