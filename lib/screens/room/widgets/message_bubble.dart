import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/models/data/message.dart';
import 'package:nane_client/providers/user.dart';
import 'package:nane_client/utils/datetime.dart';

class MessageBubble extends StatelessWidget {
  final Message message;
  final Message? previousMessage;
  final Message? nextMessage;

  const MessageBubble({
    required this.message,
    required this.previousMessage,
    required this.nextMessage,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<UserProvider>().user;
    final byMe = currentUser!.username == message.sender!.username;

    final bg = byMe
        ? Theme.of(context).primaryColor.withOpacity(0.12)
        : Colors.blueGrey.withOpacity(0.06);
    final align = byMe ? Alignment.centerRight : Alignment.centerLeft;

    BorderRadius radius;
    final nextDifferentDay =
        !areOnSameDay(message.created, nextMessage?.created);
    final prevDifferentDay =
        !areOnSameDay(message.created, previousMessage?.created);
    final nextNull = nextMessage == null;
    final prevNull = previousMessage == null;
    final nextByMe = currentUser.username == nextMessage?.sender?.username;
    final prevByMe = currentUser.username == previousMessage?.sender?.username;

    if (byMe) {
      radius = BorderRadius.only(
        topLeft: Radius.circular(15),
        bottomLeft: Radius.circular(15),
        topRight: Radius.circular(
          !prevByMe || prevDifferentDay || prevNull ? 15 : 5,
        ),
        bottomRight: Radius.circular(
          !nextByMe || nextDifferentDay || nextNull ? 15 : 5,
        ),
      );
    } else {
      radius = BorderRadius.only(
        topLeft: Radius.circular(
          prevByMe || prevDifferentDay || prevNull ? 15 : 5,
        ),
        bottomLeft: Radius.circular(
          nextByMe || nextDifferentDay || nextNull ? 15 : 5,
        ),
        topRight: Radius.circular(15),
        bottomRight: Radius.circular(15),
      );
    }

    final messageTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 10.0,
    );

    return Align(
      alignment: align,
      child: Container(
        margin: EdgeInsets.only(bottom: 2, top: 2, left: 14, right: 14),
        padding: const EdgeInsets.all(8.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.67,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: radius,
        ),
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: 4,
              right: !byMe ? 26 : 46,
            ),
            child: SelectableText(message.text),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Row(children: [
              Text(
                DateFormat('HH:mm').format(message.created),
                style: messageTextStyle,
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
