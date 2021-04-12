// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_settings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetServerSettingsResponse _$GetServerSettingsResponseFromJson(Map json) {
  return GetServerSettingsResponse(
    result: ServerSettings.fromJson(json['result'] as Map),
  );
}

Map<String, dynamic> _$GetServerSettingsResponseToJson(
        GetServerSettingsResponse instance) =>
    <String, dynamic>{
      'result': instance.result.toJson(),
    };
