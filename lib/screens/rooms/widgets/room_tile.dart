import 'package:flutter/material.dart';

import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/screens/room/room.dart';
import 'package:nane_client/utils/navigation.dart';

class RoomTile extends StatelessWidget {
  const RoomTile({required this.room, Key? key}) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(room.name),
      subtitle: Text(
        room.lastMessage?.text ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        navigateTo(context, RoomScreen(room: room));
      },
    );
  }
}
