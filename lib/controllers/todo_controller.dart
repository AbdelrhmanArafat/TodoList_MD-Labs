import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/models/task_model.dart';

class TodoController extends GetxController {
  var tasks = <TaskModel>[].obs;
  final TextEditingController taskController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void addTask() {
    if (taskController.text.isNotEmpty) {
      tasks.add(TaskModel(title: taskController.text));
      taskController.clear();
      saveTasks();
    }
  }

  void toggleTaskCompletion(int index) {
    tasks[index].isCompleted = !tasks[index].isCompleted;
    saveTasks();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => task.toJson()).toList();
    prefs.setString('tasks', taskList.toString());
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskString = prefs.getString('tasks');
    if (taskString != null) {
      final taskList = taskString.split(',').map(
        (taskJson) {
          final taskMap = taskJson.trim().split(':');
          return TaskModel(
            title: taskMap[0],
            isCompleted: taskMap[1] == 'true',
          );
        },
      ).toList();
      tasks.addAll(taskList);
    }
  }
}
