import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_friend_state.dart';

class SearchFriendCubit extends Cubit<SearchFriendState> {
  final List<String> _friends = [
    "Alice",
    "Bob",
    "Charlie",
    "David",
    "Eva",
    "Frank",
    "Grace",
    "Hannah",
  ];

  SearchFriendCubit() : super(SearchFriendInitial());

  void searchFriend(String query) {
    if (query.isEmpty) {
      emit(SearchFriendLoaded(const []));
      return;
    }

    final filteredFriends = _friends
        .where((friend) => friend.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(SearchFriendLoaded(filteredFriends));
  }
}
