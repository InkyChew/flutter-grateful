import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_grateful/models/msg.dart';
import 'package:flutter_grateful/services/msg_service.dart';

part 'msg_event.dart';
part 'msg_state.dart';

class MsgBloc extends Bloc<MsgEvent, MsgState> {
  final MsgService _msgService;

  MsgBloc(this._msgService) : super(Initial()) {
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
      var msgs = await _msgService.getMessages(to: event.to, from: event.from);
      emit(MsgListLoaded(msgs));
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onUpdateMsg(
    UpdateMsgEvent event,
    Emitter<MsgState> emit,
  ) async {
    try {
      emit(Loading());
      await _msgService.updateMessage(event.msg);
      emit(MsgUpdated());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }

  Future<void> _onRemoveMsg(
    RemoveMsgEvent event,
    Emitter<MsgState> emit,
  ) async {
    try {
      // handle API calls
      emit(Loading());
      _msgService.deleteMessage(event.msg);
      emit(MsgUpdated());
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
