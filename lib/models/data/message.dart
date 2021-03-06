import 'package:json_annotation/json_annotation.dart';

import 'package:nane_client/utils/json.dart';

import 'user.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  const Message({
    required this.room,
    required this.text,
    this.created,
    this.sender,
  });

  final String room;
  final String text;
  @JsonKey(
    fromJson: dateTimeFromJson,
    toJson: dateTimeToJson,
  )
  final DateTime? created;
  final User? sender;

  factory Message.fromJson(Map json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
