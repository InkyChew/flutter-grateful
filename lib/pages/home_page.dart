import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/home_bloc.dart';
import 'package:flutter_grateful/bloc/msg_bloc.dart';
import 'package:flutter_grateful/pages/msg_edit_page.dart';
import 'package:flutter_grateful/services/msg_service.dart';
import 'package:flutter_grateful/widgets/msg_count_widget.dart';

MsgService _msgService = MsgService();

class HomePage extends StatelessWidget {
  final int userId = 1;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(_msgService)..add(HomeLoadedEvent(userId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
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
                    MsgCountWidget(
                      text: 'All',
                      userId: userId,
                      msgService: _msgService,
                      count: state.allMessages.length,
                    ),
                    const SizedBox(width: 16.0),
                    MsgCountWidget(
                      from: -1,
                      text: 'Receive',
                      userId: userId,
                      msgService: _msgService,
                      count: state.receivedMessages.length,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Something went wrong.'));
            }
          },
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => MsgBloc(_msgService),
                    child: const MsgEditPage(),
                  ),
                ),
              );

              if (context.mounted) {
                context.read<HomeBloc>().add(HomeLoadedEvent(userId));
              }
            },
            child: const Icon(Icons.edit),
          );
        }),
      ),
    );
  }
}
