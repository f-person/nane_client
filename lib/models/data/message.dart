import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  const Message({
    required this.room,
    required this.created,
    required this.text,
    this.sender,
  });

  final String room;
  final DateTime created;
  final String text;
  final User? sender;

  factory Message.fromJson(Map json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
