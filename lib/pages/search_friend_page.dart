import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/cubit/search_friend_cubit.dart';

class SearchFriendPage extends StatelessWidget {
  const SearchFriendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search TextField
            TextField(
              onChanged: (query) {
                // Call the search method in the cubit
                context.read<SearchFriendCubit>().searchFriend(query);
              },
              decoration: const InputDecoration(
                hintText: 'Enter friend\'s name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Friends List', style: TextStyle(fontSize: 18)),
            // BlocBuilder to rebuild the UI based on the current state
            Expanded(
              child: BlocBuilder<SearchFriendCubit, SearchFriendState>(
                builder: (context, state) {
                  if (state is SearchFriendInitial) {
                    return const Center(
                        child: Text('Start searching for friends.'));
                  } else if (state is SearchFriendLoaded) {
                    final friends = state.friends;

                    if (friends.isEmpty) {
                      return const Center(child: Text('No friends found.'));
                    }

                    return ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(friends[index]),
                          onTap: () {
                            // Show a message or perform an action when tapping a friend
                            Navigator.pop(context, friends[index]);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Sending flower to ${friends[index]}'),
                            ));
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Something went wrong.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
