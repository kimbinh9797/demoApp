import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo_application/data/constants.dart';

import '../../../../domain/entities/todo.dart';
import '../../../widgets/decoration_text_form_field.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Todo'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.todoList.length,
                  itemBuilder: (context, index) {
                    return _buildItem(index);
                  },
                ),
              ),
              controller.isAdding.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          TextField(
                            decoration:
                                decorationTextFormField(hintText: "Title"),
                            controller: controller.titleController,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          TextField(
                            decoration: decorationTextFormField(
                                hintText: "Description"),
                            controller: controller.descriptionController,
                          ),
                          SizedBox(height: Get.height * 0.01),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  kPrimaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(kBorderRadius),
                                  side: const BorderSide(color: kPrimaryColor),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (controller.titleController.text.isNotEmpty &&
                                  controller
                                      .descriptionController.text.isNotEmpty) {
                                Todo item = Todo(
                                  idUser: 1,
                                  title: controller.titleController.text,
                                  description:
                                      controller.descriptionController.text,
                                );
                                controller.addTodo(item);
                                controller.titleController.text = "";
                                controller.descriptionController.text = "";
                              }
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => FloatingActionButton(
          backgroundColor: kPrimaryColor,
          onPressed: () {
            controller.isAdding.value = !controller.isAdding.value;
          },
          child: controller.isAdding.value
              ? const Icon(Icons.remove)
              : const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.todoList[index].title.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.todoList[index].description.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                controller.deleteTodo(controller.todoList[index]);
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
          ],
        ),
      ),
    );
  }
}
