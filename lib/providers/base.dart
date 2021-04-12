import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:nane_client/constants/setting.dart';

class BaseProvider with ChangeNotifier {
  BaseProvider() {
    _initDio();
    _initStorage();
  }

  late Dio _dio;
  late FlutterSecureStorage _storage;

  Dio get dio => _dio;
  FlutterSecureStorage get storage => _storage;

  void _initDio() {
    _dio = Dio(BaseOptions(
      baseUrl: SettingConstants.apiBaseUrl,
      headers: {'Content-Type': 'application/json'},
    ));

    notifyListeners();
  }

  void _initStorage() {
    _storage = FlutterSecureStorage();

    notifyListeners();
  }
}
