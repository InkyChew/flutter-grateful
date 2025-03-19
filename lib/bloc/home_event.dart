part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeLoadedEvent extends HomeEvent {
  final int userId;

  const HomeLoadedEvent(this.userId);
}
