part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String error;

  const HomeError(this.error);
}

final class HomeLoaded extends HomeState {
  final List<Msg> allMessages;
  final List<Msg> receivedMessages;

  const HomeLoaded(this.allMessages, this.receivedMessages);
}
