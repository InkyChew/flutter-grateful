import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/msg_bloc.dart';
import 'package:flutter_grateful/widgets/msg_widget.dart';

class MsgListPage extends StatelessWidget {
  final int userId;
  const MsgListPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocConsumer<MsgBloc, MsgState>(
                listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MsgListLoaded) {
                    final messages = state.msgList;

                    if (messages.isEmpty) {
                      return const Center(child: Text('No messages found.'));
                    }

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MsgWidget(
                          userId: userId,
                          msg: messages[index],
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
