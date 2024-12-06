import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:hackathon_frontend/auth/models/core/user.dart';
import 'package:hackathon_frontend/auth/models/services/user_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<User>();
  final UserService _userService = UserService();

  Future<Either<String, dynamic>> registerUser(
      String userName,
      String firstName,
      String lastName,
      String gender,
      String email,
      String phoneNumber,
      String password,
      String dateOfBirth) async {
    isLoading(true);
    var result = await _userService.register(userName, firstName, lastName,
        gender, email, phoneNumber, password, dateOfBirth);

    isLoading(false);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, dynamic>> logInUser(
      String userName, String password) async {
    isLoading(true);
    var result = await _userService.loginUser(userName, password);
    isLoading(false);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, User>> getUserDetails() async {
    var result = await _userService.getUserDetails();

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, User>> updateUserPartially(
      String profilePicture) async {
    var userDetailsResult = await getUserDetails();

    return userDetailsResult.fold((error) {
      debugPrint('Error fetching user details: $error');
      return Left('Error fetching user details: $error');
    }, (user) async {
      int userId = user.id!;

      Map<String, dynamic> updatedFields = {
        "profile_picture": profilePicture,
      };

      var updatedResult =
          await _userService.updateUserPartially(userId, updatedFields);

      return updatedResult.fold((l) => left(l), (r) => right(r));
    });
  }

  Future<Either<String, String>> logOutUser() async {
    var result = await _userService.logoutUser();

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, String>> deleteAccount() async {
    var result = await _userService.deleteAccount();

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }
}
