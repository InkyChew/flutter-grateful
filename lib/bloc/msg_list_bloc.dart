import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_grateful/models/msg.dart';
import 'package:flutter_grateful/services/msg_service.dart';

part 'msg_list_event.dart';
part 'msg_list_state.dart';

class MsgListBloc extends Bloc<MsgListEvent, MsgListState> {
  final MsgService _msgService;

  MsgListBloc(this._msgService) : super(MsgListInitial()) {
    on<GetMsgListEvent>(_onLoadMsgList);
  }

  Future<void> _onLoadMsgList(
    GetMsgListEvent event,
    Emitter<MsgListState> emit,
  ) async {
    try {
      // handle API calls
      emit(MsgListLoading());
      var msgs = await _msgService.getMessages(to: event.to, from: event.from);
      emit(MsgListLoaded(msgs));
    } catch (e) {
      emit(MsgListError(e.toString()));
    }
  }
}
