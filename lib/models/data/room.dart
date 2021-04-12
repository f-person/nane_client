import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  const Room({
    required this.name,
    this.lastMessage,
  });

  final String name;
  final Message? lastMessage;

  factory Room.fromJson(Map json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
