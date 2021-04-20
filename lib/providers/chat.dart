import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:nane_client/constants/setting.dart';
import 'package:nane_client/models/data/message.dart';
import 'package:nane_client/models/data/room.dart';
import 'package:nane_client/models/provider.dart';
import 'package:nane_client/models/response/get_room_messages_response.dart';
import 'package:nane_client/models/response/get_rooms_response.dart';

class ChatProvider extends ProviderModel with ChangeNotifier {
  ChatProvider() {
    Timer.periodic(
      const Duration(milliseconds: 1000),
      (timer) {
        if (_channel == null) _connect();
      },
    );
  }

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  bool _isConnected = false;

  String? _username;

  List<Room> _rooms = [];
  final Map<String, List<Message>> _messages = {};

  bool get isConnected => _isConnected;

  void _setConnected(bool value) {
    _isConnected = value;
    notifyListeners();
  }

  List<Room> get rooms {
    final roomsCopy = [..._rooms];
    roomsCopy.sort(
      (a, b) => b.lastMessage!.created!.compareTo(a.lastMessage!.created!),
    );

    return roomsCopy;
  }

  void closeConnection() {
    _setConnected(false);
    _subscription?.cancel();
    _channel?.sink.close();
    _channel = null;
  }

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
    _channel?.sink.add(json.encode(message.toJson()));
  }

  void updateUsername(String? username) {
    closeConnection();
    _username = username;
    if (username != null) _connect();
  }

  Future<void> _connect() async {
    if (_channel != null) return;

    final now = DateTime.now();
    print('conencting $now');

    _channel = WebSocketChannel.connect(
      Uri.parse('${SettingConstants.webSocketUrl}?username=$_username'),
    );
    _listen();
  }

  Future<void> _listen() async {
    _subscription = _channel!.stream.listen((dynamic raw) async {
      print('_channel: $raw ${DateTime.now()}');

      final message = Message.fromJson(json.decode(raw as String) as Map);

      final index = _rooms.indexWhere((r) => r.name == message.room);
      if (index != -1) {
        _rooms[index] = _rooms[index].copyWith(lastMessage: message);
      } else {
        final room = Room(name: message.room, lastMessage: message);
        _rooms.add(room);
      }
      notifyListeners();

      if (_messages[message.room] != null) {
        _messages[message.room]!.add(message);
        notifyListeners();
      }
    }, onDone: closeConnection, onError: (_) => closeConnection());
    _setConnected(true);
  }
}
