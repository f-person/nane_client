// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rooms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRoomsResponse _$GetRoomsResponseFromJson(Map json) {
  return GetRoomsResponse(
    result: (json['result'] as List<dynamic>)
        .map((e) => Room.fromJson(e as Map))
        .toList(),
  );
}

Map<String, dynamic> _$GetRoomsResponseToJson(GetRoomsResponse instance) =>
    <String, dynamic>{
      'result': instance.result.map((e) => e.toJson()).toList(),
    };
