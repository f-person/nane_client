import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'package:nane_client/providers/chat.dart';
import 'package:nane_client/providers/user.dart';

import 'widgets/fab.dart';
import 'widgets/room_tile.dart';

class RoomsScreen extends HookWidget {
  const RoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(true);

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        try {
          await context.read<ChatProvider>().fetchRooms();
        } finally {
          isLoading.value = false;
        }
      });

      return () {};
    }, const []);

    final rooms = context.select((ChatProvider chat) => chat.rooms);

    Widget buildBody() {
      if (rooms.isNotEmpty) {
        return ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return RoomTile(room: rooms[index]);
          },
        );
      }
      if (isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      return Center(child: Text('В этой коробке игрушек чатов не нашлось'));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Игрушечные комнаты'), actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            context.read<UserProvider>().setUser(null);
            context.read<ChatProvider>().closeConnection();
          },
        ),
      ]),
      floatingActionButton: RoomsFloatingActionButton(),
      body: buildBody(),
    );
  }
}
