import 'package:json_annotation/json_annotation.dart';

import 'package:nane_client/models/data/server_settings.dart';

part 'server_settings_response.g.dart';

@JsonSerializable()
class GetServerSettingsResponse {
  const GetServerSettingsResponse({required this.result});

  final ServerSettings result;

  factory GetServerSettingsResponse.fromJson(Map json) =>
      _$GetServerSettingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetServerSettingsResponseToJson(this);
}
