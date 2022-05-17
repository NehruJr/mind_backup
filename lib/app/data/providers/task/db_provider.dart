import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../models/task_model.dart';
import '../../services/storage/storage_services.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<TaskModel> readTasks() {
    var tasks = <TaskModel>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(TaskModel.fromJson(e)));
    return tasks;
  }

  void writeTasks(List<TaskModel> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
