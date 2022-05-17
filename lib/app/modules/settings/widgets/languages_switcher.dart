import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../controllers/settings_controller.dart';

class LanguagesSwitcher extends StatelessWidget {
  LanguagesSwitcher({Key? key}) : super(key: key);
  final settingsCtr = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.0.wp,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: kBlueColor.withOpacity(0.3)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  iconSize: 8.0.wp,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        english,
                        style: TextStyle(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                      value: ene,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        arabic,
                        style: TextStyle(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                      value: ara,
                    ),
                  ],
                  value: settingsCtr.langLocale.value,
                  onChanged: (value) {
                    settingsCtr.changeLanguage(value!);
                    Get.updateLocale(Locale(value));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
