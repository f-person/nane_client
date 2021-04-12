import 'package:flutter/foundation.dart';

import 'package:nane_client/models/data/message.dart';
import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/models/provider.dart';
import 'package:nane_client/models/response/get_room_messages_response.dart';
import 'package:nane_client/models/response/get_rooms_response.dart';

class ChatProvider extends ProviderModel with ChangeNotifier {
  List<Room> _rooms = [];

  List<Room> get rooms => [..._rooms];

  final Map<String, List<Message>> _messages = {};

  Future<void> fetchRooms() async {
    final response = await dio.get('/rooms');
    final result = GetRoomsResponse.fromJson(response.data as Map);
    _rooms = result.result;
    notifyListeners();
  }

  Future<void> fetchRoomMessages(Room room) async {
    final response = await dio.get('/rooms/${room.name}/history');
    final result = GetRoomMessagesResponse.fromJson(response.data as Map);
    _messages[room.name] = result.result;
    notifyListeners();
  }

  List<Message> getMessagesByRoom(Room room) => _messages[room.name] ?? [];
}
