import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

import 'message.dart';

part 'room.g.dart';

@JsonSerializable()
@CopyWith()
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
