import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:nane_client/constants/storage_keys.dart';
import 'package:nane_client/models/data/user.dart';
import 'package:nane_client/models/provider.dart';

class UserProvider extends ProviderModel with ChangeNotifier {
  UserProvider({User? user, Dio? dio}) {
    _user = user;
    this.dio = dio;

    if (_user == null) {
      _readUser().then((user) {
        _user = user;
        notifyListeners();
      });
    }
  }

  User? _user;

  User? get user => _user;

  Future<void> setUser(User? user) async {
    _user = user;
    notifyListeners();

    if (user == null) {
      return storage.delete(key: StorageKeys.user);
    }

    return storage.write(
      key: StorageKeys.user,
      value: json.encode(user.toJson()),
    );
  }

  Future<User?> _readUser() async {
    final raw = await storage.read(key: StorageKeys.user);
    if (raw == null) return null;

    return User.fromJson(json.decode(raw) as Map);
  }
}
