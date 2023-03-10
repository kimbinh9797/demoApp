import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_application/app/common/constants.dart';
import 'package:todo_application/app/data/models/todo.dart';
import 'package:todo_application/app/services/s_sqlite.dart';

import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  SqliteServices sqliteServices = SqliteServices();
  RxList<Todo> todoList = <Todo>[].obs;
  RxBool isAdding = false.obs;

  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();

  Future<void> onInitialized() async {
    todoList.value = await sqliteServices.getTodoList();
  }

  Future<void> addTodo(Todo item) async {
    await sqliteServices.insertTodo(item);
    todoList.value = await sqliteServices.getTodoList();
  }

  Future<void> deleteTodo(Todo item) async {
    await sqliteServices.deleteTodo(item);
    todoList.value = await sqliteServices.getTodoList();
  }

  Future<void> logout() async{
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
