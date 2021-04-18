import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/models/data/message.dart';
import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/providers/chat.dart';

class MessageInput extends HookWidget {
  const MessageInput({required this.room, Key? key}) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final isButtonActive = useState<bool>(false);
    String previousText = usePrevious<String>('') ?? '';

    void sendMessage() {
      if (controller.text.trim().isEmpty) return;

      final message = Message(
        room: room.name,
        text: controller.text,
      );
      controller.clear();
      isButtonActive.value = false;
      context.read<ChatProvider>().sendMessage(message);
    }

    return TextField(
      controller: controller,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Игрушечное сообщение',
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.black12,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send_outlined),
          onPressed: controller.text.isEmpty ? null : sendMessage,
        ),
      ),
      onChanged: (value) {
        if (previousText.length < 2 || value.length < 2) {
          isButtonActive.value = value.isNotEmpty;
          previousText = value;
        }
      },
    );
  }
}
