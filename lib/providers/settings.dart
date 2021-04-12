import 'package:flutter/foundation.dart';

import 'package:nane_client/constants/setting.dart';
import 'package:nane_client/models/data/server_settings.dart';
import 'package:nane_client/models/provider.dart';
import 'package:nane_client/models/response/server_settings_response.dart';

class SettingsProvider extends ProviderModel with ChangeNotifier {
  ServerSettings _settings = SettingConstants.defaultServerSettings;

  ServerSettings get settings => _settings;

  Future<void> fetchServerSettings() async {
    final response = await dio.get('/settings');
    final result = GetServerSettingsResponse.fromJson(response.data as Map);
    _settings = result.result;
    notifyListeners();
  }
}
