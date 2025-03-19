import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/models/msg.dart';
import 'package:flutter_grateful/services/msg_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MsgService _msgService;

  HomeBloc(this._msgService) : super(HomeInitial()) {
    on<HomeLoadedEvent>(_onLoadHome);
  }

  Future<void> _onLoadHome(
    HomeLoadedEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
  
      final all = await _msgService.getMessages(to: 1);
      final recevied = await _msgService.getMessages(to: 1, from: -1);

      emit(HomeLoaded(all, recevied));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
