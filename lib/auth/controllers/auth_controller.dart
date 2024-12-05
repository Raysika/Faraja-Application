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
      String email,
      String phoneNumber,
      String password,
      DateTime dateOfBirth) async {
    isLoading(true);
    var result = await _userService.register(userName, firstName, lastName,
        email, phoneNumber, password, dateOfBirth);

    isLoading(false);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, dynamic>> logIn(String userName, String password)  async{
    isLoading(true);
    var result = await _userService.loginUser(userName, password);
    isLoading(false);
    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }
}
