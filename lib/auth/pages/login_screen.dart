import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hackathon_frontend/auth/controllers/controllers.dart';
import 'package:hackathon_frontend/display/display.dart';
import 'package:hackathon_frontend/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  // bool _loading = false;

  void _togglePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ResponsiveWidgetFormLayout(
        buildPageContent: (BuildContext context, Color? color) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(Constants.SPACING * 2),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Constants.ROUNDNESS),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                      child: Logo(
                    size: 300,
                  )),
                  const SizedBox(height: 30),
                  const Text(
                    "Hello, Welcome back 👋",
                    style: TextStyle(fontSize: 40),
                  ),
                  const SizedBox(height: 10),
                  FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Username",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'username',
                            decoration: const InputDecoration(
                              hintText: "jonte@254",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.person_2),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(2),
                            ]),
                          ),
                          const SizedBox(height: Constants.SPACING),
                          const Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          FormBuilderTextField(
                            name: 'password',
                            obscureText: _hidePassword,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.lock),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: _togglePassword,
                                icon: Icon(
                                  _hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(6),
                            ]),
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            return Center(
                              child: _authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : OutlinedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.saveAndValidate()) {
                                          var result =
                                              await _authController.logIn(
                                            _formKey.currentState!
                                                .value['username'],
                                            _formKey.currentState!
                                                .value['password'],
                                          );
                                          result.fold(
                                            (error) {
                                              Get.snackbar("Error", "There was an error signing in, Please try again",
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            },
                                            (user) {
                                              Get.toNamed(
                                                  RouteNames.MAIN_SCREEN);
                                            },
                                          );
                                        }
                                        else {
                                          debugPrint("Form validation failed");
                                        }
                                      },
                                      child: const Text("Login"),
                                    ),
                            );
                          }),
                          // const SizedBox(height: Constants.SPACING),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Don't have an account,"),
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(RouteNames.REGISTRATION_SCREEN);
                                  },
                                  child: const Text("Create an Account")),
                            ],
                          ),
                          // const SizedBox(height: Constants.SPACING),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     const Text("Can't remember your password,"),
                          //     TextButton(
                          //       onPressed: () {},
                          //       child: const Text("Forgot Password"),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
