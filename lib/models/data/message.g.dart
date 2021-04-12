// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) {
  return Message(
    room: json['room'] as String,
    created: DateTime.parse(json['created'] as String),
    text: json['text'] as String,
    sender:
        json['sender'] == null ? null : User.fromJson(json['sender'] as Map),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'room': instance.room,
      'created': instance.created.toIso8601String(),
      'text': instance.text,
      'sender': instance.sender?.toJson(),
    };
