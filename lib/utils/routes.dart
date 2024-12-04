import 'package:get/get.dart';
import 'package:hackathon_frontend/app/navigation/main_screen.dart';
import 'package:hackathon_frontend/auth/pages/pages.dart';

import 'utils.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RouteNames.LOGIN_SCREEN,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: RouteNames.REGISTRATION_SCREEN,
      page: () => const RegistrationScreen(),
    ),
    GetPage(
      name: RouteNames.MAIN_SCREEN,
      page: () => const MainScreen(),
    ),
  ];
}