import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/screens/room/room.dart';
import 'package:nane_client/utils/navigation.dart';

class RoomsFloatingActionButton extends StatelessWidget {
  const RoomsFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => _EnterRoomNameDialog(),
        );
      },
      child: Icon(Icons.add),
    );
  }
}

class _EnterRoomNameDialog extends HookWidget {
  const _EnterRoomNameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 16),
          TextField(
            autofocus: true,
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Название чата',
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
            ),
          ),
          ElevatedButton(
            onPressed: () {
              navigateTo(
                context,
                RoomScreen(room: Room(name: controller.text)),
              );
            },
            child: Text('Открыть'),
          ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }
}
