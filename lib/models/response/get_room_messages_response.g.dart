// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_room_messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomMessagesResponse _$GetRoomMessagesResponseFromJson(Map json) {
  return GetRoomMessagesResponse(
    result: (json['result'] as List<dynamic>)
        .map((e) => Message.fromJson(e as Map))
        .toList(),
  );
}

Map<String, dynamic> _$GetRoomMessagesResponseToJson(
        GetRoomMessagesResponse instance) =>
    <String, dynamic>{
      'result': instance.result.map((e) => e.toJson()).toList(),
    };
