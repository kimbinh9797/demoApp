import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/data/constants.dart';
import 'package:todo_application/data/helpers/database_helper.dart';

import '../../../../domain/entities/todo.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  DatabaseHelper databaseHelper = DatabaseHelper();
  RxList<Todo> todoList = <Todo>[].obs;
  RxBool isAdding = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> onInitialized() async {
    todoList.value = await databaseHelper.getTodoList();
  }

  Future<void> addTodo(Todo item) async {
    await databaseHelper.insertTodo(item);
    todoList.value = await databaseHelper.getTodoList();
  }

  Future<void> deleteTodo(Todo item) async {
    await databaseHelper.deleteTodo(item);
    todoList.value = await databaseHelper.getTodoList();
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(kCheckLogin, false);
    Get.offAllNamed(Routes.SIGN_IN);
  }

  @override
  void onInit() {
    super.onInit();
    onInitialized();
  }
}
