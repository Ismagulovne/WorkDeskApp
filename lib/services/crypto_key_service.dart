import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CryptoKeyService {
  static final CryptoKeyService _instance = CryptoKeyService._internal();
  final _secureStorage = const FlutterSecureStorage();

  factory CryptoKeyService() {
    return _instance;
  }

  CryptoKeyService._internal();

  Future<String> getDeviceId() async {
    try {
      final deviceId = await _secureStorage.read(key: 'device_id');
      return deviceId ?? 'unknown_device';
    } catch (e) {
      return 'unknown_device';
    }
  }

  Future<bool> storePINHash(String pin) async {
    try {
      final hash = sha256.convert(pin.codeUnits).toString();
      await _secureStorage.write(key: 'pin_hash', value: hash);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyPIN(String pin) async {
    try {
      final hash = sha256.convert(pin.codeUnits).toString();
      final storedHash = await _secureStorage.read(key: 'pin_hash');
      return hash == storedHash;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllKeys() async {
    try {
      await _secureStorage.deleteAll();
    } catch (e) {
      // Silently fail
    }
  }

  String getDeviceFingerprint() {
    return sha256.convert('device_binding_key'.codeUnits).toString();
  }
}
