import 'package:hive_flutter/hive_flutter.dart';
import 'cache_service.dart';

class CacheServiceImpl implements CacheService {
  CacheServiceImpl();

  late Box box;
  bool _isInitialized = false;

  static const String _boxName = "ecommerce";
  static const String _isLoggedIn = "isLoggedIn";
  static const String _bearerToken = "bearerToken";
  static const String _fcmToken = "fcmToken";

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    box = await Hive.openBox(_boxName);
    _isInitialized = true;  // Mark the box as initialized
  }

  // Make sure the box is initialized before returning any values
  Future<void> _checkInitialization() async {
    if (!_isInitialized) {
      await init();  // Ensure init() is called if it's not already done
    }
  }

  @override
  Future<bool> get isLoggedIn async {
    await _checkInitialization();  // Ensure initialization
    return await _read(_isLoggedIn) ?? false;
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    await _checkInitialization();  // Ensure initialization
    await _save(_isLoggedIn, value);
  }

  @override
  Future<String?> get bearerToken async {
    await _checkInitialization();  // Ensure initialization
    return await _read(_bearerToken);
  }

  @override
  Future<void> setBearerToken(String value) async {
    await _checkInitialization();  // Ensure initialization
    await _save(_bearerToken, value);
  }

  @override
  Future<String?> get fcmToken async {
    await _checkInitialization();  // Ensure initialization
    return await _read(_fcmToken);
  }

  @override
  Future<void> setFcmToken(String value) async {
    await _checkInitialization();  // Ensure initialization
    await _save(_fcmToken, value);
  }

  @override
  Future<void> delete(String key) async {
    await _checkInitialization();  // Ensure initialization
    await box.delete(key);
  }

  @override
  Future<void> deleteAll() async {
    await _checkInitialization();  // Ensure initialization
    await box.clear();
  }

  Future<void> _save(String key, dynamic value) async {
    await box.put(key, value);
  }

  Future<dynamic> _read(String key) async {
    return box.get(key);
  }
}
