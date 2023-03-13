import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_application/data/constants.dart';
import 'package:todo_application/app/routes/app_pages.dart';
import '../../../widgets/decoration_text_form_field.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
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
                "LOGIN",
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
                    "Don't have an Account?",
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(Routes.SIGN_UP),
                    child: const Text(
                      "Sign up",
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
                } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])')
                    .hasMatch(value)) {
                  return "Please enter correct password";
                } else {
                  return null;
                }
              },
              onChanged: (value) => controller.password.value = value,
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
              onPressed: () {
                controller.handleSignIn(
                    controller.email.value, controller.password.value);
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
                          "Login",
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
