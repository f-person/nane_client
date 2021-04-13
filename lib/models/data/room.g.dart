// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension RoomCopyWith on Room {
  Room copyWith({
    Message? lastMessage,
    String? name,
  }) {
    return Room(
      lastMessage: lastMessage ?? this.lastMessage,
      name: name ?? this.name,
    );
  }
}

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
