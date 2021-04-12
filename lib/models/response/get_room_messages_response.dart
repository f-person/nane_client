import 'package:json_annotation/json_annotation.dart';

import 'package:nane_client/models/data/message.dart';

part 'get_room_messages_response.g.dart';

@JsonSerializable()
class GetRoomMessagesResponse {
  const GetRoomMessagesResponse({required this.result});

  final List<Message> result;

  factory GetRoomMessagesResponse.fromJson(Map json) =>
      _$GetRoomMessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRoomMessagesResponseToJson(this);
}
