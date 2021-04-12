import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:nane_client/models/data/server_settings.dart';
import 'package:nane_client/models/provider.dart';

class SettingsProvider extends ProviderModel with ChangeNotifier {
  SettingsProvider({required ServerSettings settings, Dio? dio}) {
    _settings = settings;
    this.dio = dio;
  }

  late ServerSettings _settings;

  ServerSettings get settings => _settings;
}
