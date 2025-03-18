import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/msg.dart';

part 'msg_edit_event.dart';
part 'msg_edit_state.dart';

class MsgEditBloc extends Bloc<MsgEditEvent, MsgEditState> {
  MsgEditBloc() : super(MsgEditInitial()) {
    on<MsgEditEvent>(_onMessageEdit);
  }

  Future<void> _onMessageEdit(
    MsgEditEvent event,
    Emitter<MsgEditState> emit,
  ) async {
    emit(MsgEditLoading());
    if (event is SubmitMsgEvent) {
      try {
        // Here you would typically handle API calls or any async tasks
        // For now, we simulate a successful submission
        await Future.delayed(const Duration(seconds: 2));
        final Msg newMsg = Msg(
          text: event.text,
          from: event.from,
          to: event.to,
          privacy: event.privacy,
        );
        emit(MsgEditSuccess(newMsg));
      } catch (e) {
        emit(MsgEditError(e.toString()));
      }
    }
  }
}
