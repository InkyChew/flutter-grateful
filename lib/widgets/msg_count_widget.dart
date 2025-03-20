import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/msg_bloc.dart';
import 'package:flutter_grateful/pages/msg_list_page.dart';
import 'package:flutter_grateful/services/msg_service.dart';

class MsgCountWidget extends StatelessWidget {
  final int userId;
  final int? from;
  final String text;
  final int count;
  final MsgService msgService;

  const MsgCountWidget(
      {super.key,
      required this.userId,
      this.from,
      required this.text,
      required this.msgService,
      required this.count});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => MsgBloc(msgService)
                ..add(GetMsgListEvent(from: from, to: userId)),
              child: MsgListPage(
                userId: userId,
              ),
            ),
          ),
        );
      },
      child: Column(
        children: [
          Text(text),
          Text(count.toString()),
        ],
      ),
    );
  }
}
