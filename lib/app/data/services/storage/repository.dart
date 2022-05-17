import '../../models/task_model.dart';
import '../../providers/task/db_provider.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<TaskModel> readTasks() => taskProvider.readTasks();

  void writeTasks(List<TaskModel> tasks) => taskProvider.writeTasks(tasks);
}
