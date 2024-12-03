import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hackathon_frontend/display/display.dart';
import 'package:hackathon_frontend/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.SPACING),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          FormBuilderTextField(
                              name: 'phone_number',
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: "e.g. 0712345678",
                                prefixIcon: Icon(Icons.phone),
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.maxLength(10),
                                FormBuilderValidators.minLength(10)
                              ]),
                              maxLength: 10,
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
                          Center(
                            child: OutlinedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   //move to home screen
                                // } else {
                                //   return;
                                // }
                                Get.toNamed(RouteNames.MAIN_SCREEN);
                              },
                              child: const Text("Login"),
                            ),
                          ),
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
