import 'package:flutter/material.dart';
import 'package:flutter_grateful/models/msg.dart';

class MsgWidget extends StatelessWidget {
  final int userId;
  final Msg msg;
  const MsgWidget({super.key, required this.userId, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // text
            Text(msg.text),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // from
                if (userId != msg.from)
                  Text(
                    msg.from.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                const Spacer(),
                // createAt
                Text(
                  msg.createAt.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
