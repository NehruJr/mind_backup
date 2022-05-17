import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'notifications._service.dart';
import 'storage_services.dart';

class InitServices extends GetxService {
  Future<InitServices> init() async {
    await GetStorage.init();
    await Get.putAsync(() => StorageService().init());
    Get.put(NotificationsServices());
    return this;
  }
}
