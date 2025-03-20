import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/msg_edit_bloc.dart';
import 'package:flutter_grateful/bloc/msg_list_bloc.dart';
import 'package:flutter_grateful/pages/msg_edit_page.dart';
import 'package:flutter_grateful/services/msg_service.dart';
import 'package:flutter_grateful/widgets/msg_widget.dart';

class MsgListPage extends StatelessWidget {
  final int userId;
  final MsgService msgService;

  const MsgListPage(
      {super.key, required this.userId, required this.msgService});

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
              child: BlocConsumer<MsgListBloc, MsgListState>(
                listener: (context, state) {
                  if (state is MsgListError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is MsgListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MsgListLoaded) {
                    final messages = state.msgList;

                    if (messages.isEmpty) {
                      return const Center(child: Text('No messages found.'));
                    }

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => MsgEditBloc(
                                      msgService: msgService,
                                      msg: messages[index]),
                                  child: const MsgEditPage(),
                                ),
                              ),
                            );

                            if(context.mounted) {
                              context.read<MsgListBloc>().add(GetMsgListEvent(to: userId));
                            }
                          },
                          child: MsgWidget(
                            userId: userId,
                            msg: messages[index],
                          ),
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
