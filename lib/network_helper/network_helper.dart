import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hackathon_frontend/local_storage/local_storage.dart';
import 'package:hackathon_frontend/utils/utils.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  /// Logs out the user by clearing local storage and redirecting to login
  static Future<void> logOut() async {
    // Delete the tokens from local storage
    await LocalStorage.deleteToken();
    debugPrint("User logged out. Tokens cleared from local storage.");
    Get.offAllNamed(RouteNames.LOGIN_SCREEN);
  }

  static Future<http.Response?> request(http.Request request) async {
    try {
      final tokenPair = await LocalStorage.getToken();
      if (tokenPair == null || tokenPair.access.isEmpty) {
        debugPrint("Access token is missing. Logging out...");
        await logOut();
        return null;
      }

      request.headers['Authorization'] = 'Bearer ${tokenPair.access}';

      //send request
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 401) {
        debugPrint("Access token expired. Logging out...");
        await logOut();
        return null;
      }

      return response;
    } catch(e) {
      debugPrint("Error making request: $e");
      return null;
    }
  }
}