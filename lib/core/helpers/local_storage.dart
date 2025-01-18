import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// store data
class LocalStorage {
  var storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? '';
    debugPrint('Data read from secure storage: $value');
    return value;
  }

  Future<void> deleteAllSecureData() async {
    debugPrint('All Data Wiped ');

    await storage.deleteAll();
  }
}
