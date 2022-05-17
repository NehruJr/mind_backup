import 'package:get/get.dart';

import '../../../data/providers/task/db_provider.dart';
import '../../../data/services/storage/repository.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
