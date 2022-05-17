import 'package:mind_backup/app/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/settings/controllers/settings_controller.dart';

class TextUtil extends StatelessWidget {
  TextUtil({
    Key? key,
    required this.txt,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.decoration,
    this.overflow,
  }) : super(key: key);
  final settingsCtr = Get.find<SettingsController>();
  final String txt;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Text(txt.tr,
          style: TextStyle(
              fontSize: (fontSize + (settingsCtr.fontSize.value)).sp,
              fontWeight: fontWeight,
              color: color,
              decoration: decoration,
              overflow: overflow,
              fontFamily: settingsCtr.selectedFontFamily.value));
    });
  }
}
