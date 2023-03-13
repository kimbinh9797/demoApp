import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/data/constants.dart';

import 'app/routes/app_pages.dart';
import 'data/helpers/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().openDB();
  SharedPreferences pref = await SharedPreferences.getInstance();
  bool isLogin = pref.getBool(kCheckLogin) ?? false;
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: isLogin ? AppPages.INITIAL : Routes.SIGN_IN,
      getPages: AppPages.routes,
    ),
  );
}
