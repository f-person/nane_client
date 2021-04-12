import 'package:json_annotation/json_annotation.dart';

part 'server_settings.g.dart';

@JsonSerializable()
class ServerSettings {
  const ServerSettings({
    required this.maxMessageLength,
    required this.maxRoomTitleLength,
    required this.maxUsernameLength,
    this.uptime,
  });

  final int maxMessageLength;
  final int maxRoomTitleLength;
  final int maxUsernameLength;
  final int? uptime;

  factory ServerSettings.fromJson(Map json) => _$ServerSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$ServerSettingsToJson(this);
}
