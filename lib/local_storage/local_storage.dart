import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPair {
  final String access;
  final String refresh;

  TokenPair({required this.access, required this.refresh});

  factory TokenPair.fromJson(Map<String, dynamic> json) {
    return TokenPair(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
    );
  }
}

class LocalStorage {
  static Future<void> saveToken(TokenPair token) async {
    if(token.refresh.isEmpty || token.access.isEmpty) debugPrint("Cannot save tokens because they are empty");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token.access);
    await prefs.setString('refresh_token', token.refresh);
  } 

  static Future<TokenPair?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final refreshToken = prefs.getString('refresh_token');

    if (accessToken == null || accessToken.isEmpty || refreshToken == null || refreshToken.isEmpty) {
      await deleteToken();
      return null;
    }

    return TokenPair(access: accessToken, refresh: refreshToken);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
  }

    /// Save a generic key-value pair to SharedPreferences
  static Future<void> save(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Retrieve a value by key from SharedPreferences
  static Future<String> get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  /// Delete a key-value pair from SharedPreferences
  static Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Save a boolean value (e.g., account verification status) to SharedPreferences
  static Future<void> saveIsVerifiedAccount(String key, bool isVerified) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, isVerified);
  }

  /// Retrieve a boolean value by key from SharedPreferences
  static Future<bool> getIsVerified(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}