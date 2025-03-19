import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/home_bloc.dart';
import 'package:flutter_grateful/bloc/msg_bloc.dart';
import 'package:flutter_grateful/pages/msg_edit_page.dart';
import 'package:flutter_grateful/pages/msg_list_page.dart';
import 'package:flutter_grateful/services/msg_service.dart';

class HomePage extends StatelessWidget {
  final int userId = 1;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocProvider(
        create: (context) =>
            HomeBloc(MsgService())..add(HomeLoadedEvent(userId)),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) =>
                                  MsgBloc()..add(GetMsgListEvent(to: userId)),
                              child: MsgListPage(
                                userId: userId,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const Text('All'),
                          Text(state.allMessages.length.toString()),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => MsgBloc()
                                ..add(GetMsgListEvent(from: -1, to: userId)),
                              child: MsgListPage(
                                userId: userId,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          const Text('Receive'),
                          Text(state.receivedMessages.length.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => MsgBloc(),
                child: const MsgEditPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
