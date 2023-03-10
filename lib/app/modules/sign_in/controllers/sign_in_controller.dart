import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/app/common/constants.dart';
import 'package:todo_application/app/data/repositories/api_repository.dart';
import 'package:todo_application/app/routes/app_pages.dart';

class SignInController extends GetxController {
  ApiRepository apiRepository = ApiRepository();
  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxString email = "".obs;
  RxString password = "".obs;

  Future<void> handleSignIn(String email, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 2), () async {
        final res = await apiRepository.login(email, password);
        if (res["status"] == "Success") {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Incorrect email or password", "",
              snackPosition: SnackPosition.BOTTOM);
        }
        await pref.setBool(kCheckLogin, true);
        isLoading.value = false;
      });
    }
  }
}
