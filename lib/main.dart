import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/app/common/constants.dart';

import 'app/routes/app_pages.dart';
import 'app/services/s_sqlite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteServices().openDB();
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
