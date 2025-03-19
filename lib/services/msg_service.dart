import 'package:flutter_grateful/models/msg.dart';

class MsgService {
  final List<Msg> _messages = [
    Msg(
        text:
            "You are awesome.Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime, iure voluptas ducimus esse deserunt temporibus sunt recusandae provident culpa in.",
        from: 1,
        to: 1),
    Msg(
        text:
            "It's a sunny day.Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime, iure voluptas ducimus esse deserunt temporibus sunt recusandae provident culpa in.",
        from: 2,
        to: 1),
    Msg(
        text:
            "You're so beautiful.Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime,",
        from: 3,
        to: 1),
    Msg(text: "Hi it's nice to see you.", from: 1, to: 1),
    Msg(
        text:
            "Hi it's a new day.Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime, iure",
        from: 1,
        to: 1),
  ];

  MsgService();

  Future<List<Msg>> getMessages({required int to, int? from}) async {
    // handle API calls
    await Future.delayed(const Duration(seconds: 2));
    Iterable<Msg> filteredMsgList = _messages.where((m) => m.to == to);
    if (from != null) {
      filteredMsgList = _messages.where((m) {
        return (from == -1) ? m.from != to : m.from == from;
      });
    }
    return filteredMsgList.toList();
  }
}
