import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_application/app/routes/app_pages.dart';
import 'package:todo_application/data/helpers/database_helper.dart';
import '../../../../domain/entities/user.dart';

class SignUpController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;

  Future<void> handleSignUp(User user) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () async {
        var res = await databaseHelper.insertUser(user);
        if (res != 0) {
          Get.snackbar("Sign up Successfully", "",
              snackPosition: SnackPosition.BOTTOM);
          Get.offAllNamed(Routes.SIGN_IN);
        } else {
          Get.snackbar("Email already exists", "Please use another email",
              snackPosition: SnackPosition.BOTTOM);
        }
        isLoading.value = false;
      });
    }
  }
}
