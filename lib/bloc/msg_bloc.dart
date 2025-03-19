import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_grateful/models/msg.dart';

part 'msg_event.dart';
part 'msg_state.dart';

class MsgBloc extends Bloc<MsgEvent, MsgState> {
  final List<Msg> _msgList = [
    Msg(text: "You are awesome.", from: 1, to: 1),
    Msg(text: "It's a sunny day.", from: 1, to: 1),
    Msg(text: "You're so beautiful.", from: 1, to: 1),
    Msg(text: "Hi it's nice to see you.", from: 1, to: 1),
  ];

  MsgBloc() : super(Initial()) {
    on<GetMsgListEvent>(_onLoadMsgList);
    on<UpdateMsgEvent>(_onUpdateMsg);
    on<RemoveMsgEvent>(_onRemoveMsg);
  }

  Future<void> _onLoadMsgList(
    GetMsgListEvent event,
    Emitter<MsgState> emit,
  ) async {
    try {
      // handle API calls
      emit(Loading());
      await Future.delayed(const Duration(seconds: 2));
      emit(MsgListLoaded(_msgList));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onUpdateMsg(
    MsgEvent event,
    Emitter<MsgState> emit,
  ) async {
    if (event is UpdateMsgEvent) {
      try {
        // handle API calls
        emit(Loading());
        await Future.delayed(const Duration(seconds: 2));
        final Msg newMsg = Msg(
          text: event.text,
          from: event.from,
          to: event.to,
          privacy: event.privacy,
        );
        emit(MsgUpdated(newMsg));
      } catch (e) {
        emit(Error(e.toString()));
      }
    }
  }

  Future<void> _onRemoveMsg(
    RemoveMsgEvent event,
    Emitter<MsgState> emit,
  ) async {
    try {
      // handle API calls
      emit(Loading());
      final updatedMsgList =
          _msgList.where((m) => m.id != event.msg.id).toList();
      await Future.delayed(const Duration(seconds: 2));
      emit(MsgListLoaded(updatedMsgList));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
