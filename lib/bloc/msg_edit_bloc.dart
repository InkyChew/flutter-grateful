import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_grateful/models/msg.dart';
import 'package:flutter_grateful/services/msg_service.dart';

part 'msg_edit_event.dart';
part 'msg_edit_state.dart';

class MsgEditBloc extends Bloc<MsgEditEvent, MsgEditState> {
  final MsgService msgService;
  final Msg msg;

  MsgEditBloc({required this.msgService, required this.msg})
      : super(MsgEditInitial(msg)) {
    on<UpdateMsgEvent>(_onUpdateMsg);
    on<RemoveMsgEvent>(_onRemoveMsg);
  }

  Future<void> _onUpdateMsg(
    UpdateMsgEvent event,
    Emitter<MsgEditState> emit,
  ) async {
    try {
      emit(MsgEditLoading());
      await msgService.updateMessage(event.msg);
      emit(MsgEditSuccess());
    } catch (e) {
      emit(MsgEditError(e.toString()));
    }
  }

  Future<void> _onRemoveMsg(
    RemoveMsgEvent event,
    Emitter<MsgEditState> emit,
  ) async {
    try {
      // handle API calls
      emit(MsgEditLoading());
      msgService.deleteMessage(event.msg);
      emit(MsgEditSuccess());
    } catch (e) {
      emit(MsgEditError(e.toString()));
    }
  }
}
