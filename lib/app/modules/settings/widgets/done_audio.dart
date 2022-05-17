import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../controllers/settings_controller.dart';

class DoneAudioSwitcher extends StatelessWidget {
  DoneAudioSwitcher({Key? key}) : super(key: key);
  final settingsCtr = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      builder: (_) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0.wp,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: kBlueColor.withOpacity(0.3)),
              ),
              child: DropdownButtonFormField(
                  value: settingsCtr.selectedAudioForNotification.value,
                  items: settingsCtr.listOfAudios.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    settingsCtr.changeDoneAudio(value.toString());
                  }),
            ),
          ],
        );
      },
    );
  }
}
