import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/core/core.dart';
import 'app/data/services/storage/services.dart';
import 'app/modules/home/bindings/home_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => InitServices().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale(GetStorage().read<String>("lang").toString()),
      fallbackLocale: Locale(ene),
      translations: Localization(),
      theme: ThemeData(
        fontFamily: GetStorage().read<String>("fontFamily").toString(),
      ),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}
