import 'package:nane_client/models/data/server_settings.dart';

class SettingConstants {
  static const apiHost = 'https://nane.tada.team';
  static const apiBaseUrl = '$apiHost/api';
  static const defaultServerSettings = ServerSettings(
    maxMessageLength: 10500,
    maxRoomTitleLength: 50,
    maxUsernameLength: 50,
  );
}
