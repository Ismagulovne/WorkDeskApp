import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  final LocalAuthentication _localAuth = LocalAuthentication();

  factory BiometricAuthService() {
    return _instance;
  }

  BiometricAuthService._internal();

  Future<bool> isBiometricAvailable() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      return [];
    }
  }

  Future<bool> authenticate() async {
    try {
      if (!await isBiometricAvailable()) {
        return false;
      }

      return await _localAuth.authenticate(
        localizedReason: 'Подтвердите вашу личность',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
