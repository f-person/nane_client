import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/extension_methods/iterable.dart';
import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/providers/chat.dart';
import 'package:nane_client/widgets/scaffold.dart';

import 'widgets/message_bubble.dart';
import 'widgets/message_input.dart';

class RoomScreen extends HookWidget {
  const RoomScreen({required this.room, Key? key}) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    final messages =
        context.watch<ChatProvider>().getMessagesByRoom(room).reversed;

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (messages.isEmpty) {
          context.read<ChatProvider>().fetchRoomMessages(room);
        }
      });

      return () {};
    }, const []);

    return AppScaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages.elementAt(index);

              return MessageBubble(
                message: message,
                previousMessage: messages.elementAtOrNull(index + 1),
                nextMessage: messages.elementAtOrNull(index - 1),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          child: MessageInput(),
        ),
      ]),
    );
  }
}
