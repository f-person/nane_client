import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nane_client/constants/setting.dart';

/// [ProviderModel] is used for sharing fields among other providers
abstract class ProviderModel {
  final storage = FlutterSecureStorage();

  final dio = Dio(BaseOptions(
    baseUrl: SettingConstants.apiBaseUrl,
    headers: {'Content-Type': 'application/json'},
  ));
}
