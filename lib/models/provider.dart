import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [ProviderModel] is used for sharing fields among other providers
abstract class ProviderModel {
  final storage = FlutterSecureStorage();
  Dio? dio;
}
