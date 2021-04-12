import 'package:json_annotation/json_annotation.dart';

import 'package:nane_client/models/data/room.dart';

part 'get_rooms_response.g.dart';

@JsonSerializable()
class GetRoomsResponse {
  const GetRoomsResponse({required this.result});

  final List<Room> result;

  factory GetRoomsResponse.fromJson(Map json) =>
      _$GetRoomsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRoomsResponseToJson(this);
}
