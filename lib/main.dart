import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'display/display.dart';
import 'utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Faraja',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF6A4C93),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF6A4C93),
      ),
      home: const Faraja(),
      getPages: Routes.pages,
    );
  }
}

class Faraja extends StatelessWidget {
  const Faraja({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? bgColor) => Container(
          padding: const EdgeInsets.all(Constants.SPACING * 2),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Logo(size: 500),
              ),
              Text(
                "Your Mind, Your Strength: Begin Now, \nEmbrace Wellness Ahead.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onTertiaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Constants.SPACING + 10),
              const Text(
                "Let's you in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30),
              OutlinedButton(
                onPressed: () {
                  Get.toNamed(RouteNames.LOGIN_SCREEN);
                },
                child: const Text("Login"),
              ),
              const SizedBox(
                height: Constants.SPACING,
              ),
              const Text(
                "or",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: Constants.SPACING,
              ),
              OutlinedButton(
                onPressed: () {
                  Get.toNamed(RouteNames.REGISTRATION_SCREEN);
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
