import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grateful/bloc/msg_bloc.dart';
import 'package:flutter_grateful/pages/msg_edit_page.dart';
import 'package:flutter_grateful/pages/msg_list_page.dart';

class HomePage extends StatelessWidget {
  final int userId = 1;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          MsgBloc()..add(GetMsgListEvent(to: userId)),
                      child: MsgListPage(userId: userId,),
                    ),
                  ),
                );
              },
              child: const Text('All'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          MsgBloc()..add(GetMsgListEvent(from: -1, to: userId)),
                      child: MsgListPage(userId: userId,),
                    ),
                  ),
                );
              },
              child: const Text('Receive'),
            ),
          ],
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
