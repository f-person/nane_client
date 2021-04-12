// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Room _$RoomFromJson(Map json) {
  return Room(
    name: json['name'] as String,
    lastMessage: json['last_message'] == null
        ? null
        : Message.fromJson(json['last_message'] as Map),
  );
}

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'name': instance.name,
      'last_message': instance.lastMessage?.toJson(),
    };
