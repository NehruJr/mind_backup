import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/task_model.dart';
import '../../../data/services/storage/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <TaskModel>[].obs;
  final task = Rx<TaskModel?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController editController = TextEditingController();
  DateTime taskTime = DateTime.now();
  DateTime dateOfReminder = DateTime.now();
  TimeOfDay timeOfReminder = TimeOfDay.now();

  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tabIndex = 0.obs;
  RxBool isDragging = false.obs;

  RxString selectedPriority = 'Low'.tr.obs;
  List<String> listOfValue = <String>[
    'Low',
    'Medium',
    'High',
  ];

  Color priorityColor(String priority) {
    return priority == 'Low'.tr
        ? Colors.blue[200]!
        : priority == 'Medium'.tr
            ? Colors.orange[200]!
            : Colors.red[200]!;
  }

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  void changeSelectedTime(DateTime selectedTaskTime) {
    taskTime = selectedTaskTime;
    update();
  }

  void changeSelectedReminderDate(DateTime selectedDate) {
    dateOfReminder = selectedDate;
    update();
  }

  void changeSelectedReminderTime(TimeOfDay selectedTime) {
    timeOfReminder = selectedTime;
    update();
  }

  void changeDraggingValue(bool drag) {
    isDragging.value = drag;
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
    changeDraggingValue(value);
  }

  void changeTask(TaskModel? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(TaskModel taskModel) {
    if (tasks.contains(taskModel)) {
      return false;
    }
    tasks.add(taskModel);
    return true;
  }

  void deleteTask(TaskModel task) {
    tasks.remove(task);
  }

  updateTask(TaskModel taskModel, String title) {
    var todos = taskModel.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = taskModel.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(taskModel);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {'title': title, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([...doingTodos, ...doneTodos]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx = tasks.indexOf(task.value);
    tasks[oldIdx] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }

  deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos
        .indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    doneTodos.removeAt(index);
    doneTodos.refresh();
  }

  deleteDoingTodo(dynamic doingTodo) {
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));
    doingTodos.removeAt(index);
    doingTodos.refresh();
  }

  bool isTodosEmpty(TaskModel task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(TaskModel task) {
    var res = 0;
    for (int i = 0; i < task.todos!.length; i++) {
      res += i;
    }
    return res;
  }

  int getTotalTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
