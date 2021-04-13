// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map json) {
  return Message(
    room: json['room'] as String,
    text: json['text'] as String,
    created: dateTimeFromJson(json['created'] as String?),
    sender:
        json['sender'] == null ? null : User.fromJson(json['sender'] as Map),
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'room': instance.room,
      'text': instance.text,
      'created': dateTimeToJson(instance.created),
      'sender': instance.sender?.toJson(),
    };
