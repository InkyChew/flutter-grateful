part of 'search_friend_cubit.dart';

sealed class SearchFriendState extends Equatable {
  @override
  List<Object> get props => [];
}

final class SearchFriendInitial extends SearchFriendState {}

final class SearchFriendLoaded extends SearchFriendState {
  final List<String> friends;

  SearchFriendLoaded(this.friends);

  @override
  List<Object> get props => [friends];
}
