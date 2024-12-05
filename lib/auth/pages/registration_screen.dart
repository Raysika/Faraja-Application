import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../display/display.dart';
import '../../utils/utils.dart';
import '../controllers/controllers.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hidePassword = true;
  final _authController = Get.find<AuthController>();
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
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
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
                children: [
                  FormBuilder(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            const DecoratedBox(
                              decoration: BoxDecoration(),
                              child: Center(
                                child: Logo(
                                  size: 300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const Text(
                              "Create Account 👋",
                              style: TextStyle(fontSize: 40),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text("Username"),
                            FormBuilderTextField(
                              name: 'user_name',
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
                            const Text("First Name"),
                            FormBuilderTextField(
                              name: 'first_name',
                              decoration: const InputDecoration(
                                  hintText: "John",
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.person)),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(2),
                              ]),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text("Last Name"),
                            FormBuilderTextField(
                              name: 'last_name',
                              decoration: const InputDecoration(
                                hintText: "Doe",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(2),
                              ]),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text("Email"),
                            FormBuilderTextField(
                              name: 'email',
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "e.g abc@gmail.com",
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(),
                              ]),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text("Date of Birth"),
                            FormBuilderDateTimePicker(
                              name: 'dob',
                              firstDate: DateTime(1920),
                              lastDate: DateTime.now(),
                              decoration: const InputDecoration(
                                hintText: "Enter your date of birth",
                                prefixIcon: Icon(Icons.calendar_month_rounded),
                                border: OutlineInputBorder(),
                              ),
                              inputType: InputType.date,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                            ),
                            const SizedBox(height: Constants.SPACING),
                            const Text("Phone Number"),
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
                            const Text("Password"),
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
                            const SizedBox(height: Constants.SPACING),
                            const Text("Confirm Password"),
                            FormBuilderTextField(
                              name: 'confirm_password',
                              obscureText: _hidePassword,
                              decoration: InputDecoration(
                                hintText: "Confirm your password",
                                prefixIcon: const Icon(Icons.password),
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
                                (value) =>
                                    _formKey.currentState!.value['password'] !=
                                            value
                                        ? "Password didn't match"
                                        : null
                              ]),
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return _authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : OutlinedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          var result = await _authController.registerUser(
                                            _formKey.currentState!.value['user_name'],
                                            _formKey.currentState!.value['first_name'],
                                            _formKey.currentState!.value['last_name'],
                                            _formKey.currentState!.value['email'],
                                            _formKey.currentState!.value['dob'],
                                            _formKey.currentState!.value['phone_number'],
                                            _formKey.currentState!.value['password'],
                                          );
                                          result.fold(
                                            (error) {
                                              Get.snackbar("Error", "There was an error registering you, please try again.",
                                                  snackPosition: SnackPosition.BOTTOM);
                                            },
                                            (user) {
                                              Get.toNamed(RouteNames.MAIN_SCREEN);
                                            },
                                          );
                                        }
                                      },
                                      child: const Text("Register"),
                                    );
                            }),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text("Already have an account,"),
                                TextButton(
                                  onPressed: () {
                                    Get.toNamed(RouteNames.LOGIN_SCREEN);
                                  },
                                  child: const Text("Login"),
                                ),
                              ],
                            ),
                          ],
                        ),
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
