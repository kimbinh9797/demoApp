import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_application/app/data/models/user.dart';
import 'package:todo_application/app/routes/app_pages.dart';

import '../../../common/constants.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "SIGN UP",
                style: TextStyle(
                  letterSpacing: 8,
                  color: kPrimaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildSignInForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => Get.offAllNamed(Routes.SIGN_IN),
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 15, color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.03, horizontal: Get.width * 0.05),
        child: Column(
          children: [
            TextFormField(
              decoration:
                  decorationTextFormField(hintText: "Name", icon: Icons.person),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                } else {
                  return null;
                }
              },
              onChanged: (value) => controller.name.value = value,
            ),
            SizedBox(height: Get.height * 0.015),
            TextFormField(
              decoration:
                  decorationTextFormField(hintText: "Email", icon: Icons.email),
              validator: (value) {
                if (!GetUtils.isEmail(value!)) {
                  return "Please enter correct email";
                } else {
                  return null;
                }
              },
              onChanged: (value) => controller.email.value = value,
            ),
            SizedBox(height: Get.height * 0.015),
            TextFormField(
              obscureText: true,
              decoration: decorationTextFormField(
                  hintText: "Password", icon: Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                } else if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])')
                    .hasMatch(value)) {
                  return "Please enter correct password with uppercase and lowercase letters";
                } else {
                  return null;
                }
              },
              onChanged: (value) => controller.password.value = value,
            ),
            SizedBox(height: Get.height * 0.015),
            TextFormField(
              obscureText: true,
              decoration: decorationTextFormField(
                  hintText: "Confirm password", icon: Icons.lock),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                } else if (value != controller.password.value) {
                  return "Please confirm correct password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: Get.height * 0.03),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(kBorderRadius),
                    side: const BorderSide(color: kPrimaryColor),
                  ),
                ),
              ),
              onPressed: () async {
                User user = User(
                  name: controller.name.value,
                  email: controller.email.value,
                  password: controller.password.value,
                );
                await controller.handleSignUp(user);
              },
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Get.width * 0.025,
                      horizontal: Get.height * 0.01),
                  child: controller.isLoading.value
                      ? SizedBox(
                          height: Get.height * 0.03,
                          width: Get.height * 0.03,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          "Sign up",
                          style: TextStyle(fontSize: 18),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
