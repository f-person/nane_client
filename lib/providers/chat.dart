import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

import 'package:nane_client/constants/setting.dart';
import 'package:nane_client/models/data/message.dart';
import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/models/provider.dart';
import 'package:nane_client/models/response/get_room_messages_response.dart';
import 'package:nane_client/models/response/get_rooms_response.dart';

class ChatProvider extends ProviderModel with ChangeNotifier {
  ChatProvider({this.username}) {
    _connect();
  }

  final String? username;

  late IOWebSocketChannel _channel;

  DateTime? _lastConnectAttempt;
  List<Room> _rooms = [];
  final Map<String, List<Message>> _messages = {};

  List<Room> get rooms {
    final roomsCopy = [..._rooms];
    roomsCopy.sort(
      (a, b) => b.lastMessage!.created!.compareTo(a.lastMessage!.created!),
    );

    return roomsCopy;
  }

  Future<void> closeConnection() => _channel.sink.close();

  Future<void> fetchRoomMessages(Room room) async {
    try {
      final response = await dio.get('/rooms/${room.name}/history');
      final result = GetRoomMessagesResponse.fromJson(response.data as Map);
      _messages[room.name] = result.result;
    } on DioError catch (error) {
      if (error.response?.statusCode == 404) {
        _messages[room.name] = [];
      }
    }
    notifyListeners();
  }

  Future<void> fetchRooms() async {
    final response = await dio.get('/rooms');
    final result = GetRoomsResponse.fromJson(response.data as Map);
    _rooms = result.result;
    notifyListeners();
  }

  List<Message> getMessagesByRoom(Room room) => _messages[room.name] ?? [];

  void sendMessage(Message message) {
    _channel.sink.add(json.encode(message.toJson()));
  }

  Future<void> _connect() async {
    if (username == null) return;

    final now = DateTime.now();

    if (_lastConnectAttempt != null &&
        now.difference(_lastConnectAttempt!) < const Duration(seconds: 2)) {
      await Future.delayed(const Duration(seconds: 4));
    }

    _channel = IOWebSocketChannel.connect(
      '${SettingConstants.webSocketUrl}?username=$username',
      pingInterval: const Duration(seconds: 3),
    );
    _listen();
  }

  Future<void> _listen() async {
    _channel.stream.listen((dynamic raw) async {
      print('_channel: $raw ${DateTime.now()}');

      final message = Message.fromJson(json.decode(raw as String) as Map);

      final index = _rooms.indexWhere((r) => r.name == message.room);
      if (index != -1) {
        _rooms[index] = _rooms[index].copyWith(lastMessage: message);
        notifyListeners();
      }

      if (_messages[message.room] != null) {
        _messages[message.room]!.add(message);
        notifyListeners();
      } else if (index == -1) {
        final room = Room(name: message.room, lastMessage: message);
        _rooms.add(room);
        notifyListeners();
      }
    }, onDone: _connect);
  }
}
