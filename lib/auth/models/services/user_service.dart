import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:hackathon_frontend/network_helper/network_helper.dart';
import 'package:hackathon_frontend/utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../../local_storage/local_storage.dart';
import '../core/user.dart';

class UserService extends NetworkHelper {
  Future<Either<String, dynamic>> register(
      String userName,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String password,
      DateTime dateOfBirth) async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.BASE_URL}/accounts/register/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'user_name': userName,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'date_of_birth': dateOfBirth
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        debugPrint("Register Response JSON: $jsonData");
        debugPrint(
            "Access token: ${jsonData['access_token']}, Refresh token: ${jsonData['refresh_token']}");
        await LocalStorage.saveToken(jsonData['access_token']);
        await LocalStorage.saveToken(jsonData['refresh_token']);
        return Right(User.fromJson(jsonData));
      } else {
        debugPrint("Error: ${response.body}");
        return Left(
            'Failed to register user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return Left('Error registering user: $e');
    }
  }

  // Login user
  Future<Either<String, User>> loginUser(
      String userName, String password) async {
    try {
      var response = await http.post(
        Uri.parse("${Constants.BASE_URL}/accounts/login/"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': userName,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        debugPrint("Login Response JSON: $jsonData");

        debugPrint("Access Token: ${jsonData['access']}");
        debugPrint("Refresh Token: ${jsonData['refresh']}");

        // Save the tokens in local storage
        if (jsonData['access'] != null && jsonData['refresh'] != null) {
          // Storing the tokens as TokenPair
          TokenPair tokenPair = TokenPair(
            access: jsonData['access'],
            refresh: jsonData['refresh'],
          );
          await LocalStorage.saveToken(tokenPair);

          // Returning the User object
          return Right(User.fromJson(jsonData));
        } else {
          debugPrint('Missing access or refresh token in the response');
          return const Left('Missing access or refresh token in the response');
        }
      } else {
        debugPrint("Error: ${response.body}");
        return Left('Failed to log in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error logging in: $e");
      return Left('Error logging in: $e');
    }
  }
}
