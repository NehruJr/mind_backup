import 'package:mind_backup/app/core/core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/text_utils.dart';
import '../controllers/settings_controller.dart';
import '../widgets/done_audio.dart';
import '../widgets/font_switcher.dart';
import '../widgets/languages_switcher.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: TextUtil(
            txt: 'Settings'.tr,
            color: Colors.black,
            fontSize: 5.0.wp,
          ),
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(4.0.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.0.wp,
              ),
              const _Languages(),
              SizedBox(
                height: 4.0.wp,
              ),
              const _Fonts(),
              SizedBox(
                height: 4.0.wp,
              ),
              Obx(() {
                return _fontSize();
              }),
              SizedBox(
                height: 4.0.wp,
              ),
              const _TodoSound(),
              SizedBox(
                height: 4.0.wp,
              ),
              const Spacer(),
              TextButton(
                  onPressed: () {},
                  child: TextUtil(
                    txt: 'cancelNoti',
                    fontSize: 8.0.sp,
                    color: Colors.red[800],
                  )),
              SizedBox(
                height: 4.0.wp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _fontSize() {
    return Row(
      children: [
        TextUtil(
            txt: 'Font Size', fontSize: 8.0.sp, fontWeight: FontWeight.normal),
        Expanded(
          child: Slider.adaptive(
              activeColor: kBlueColor,
              inactiveColor: Colors.grey[200],
              min: -2.0,
              max: 3.0,
              divisions: 6,
              value: controller.fontSize.value,
              onChanged: (value) {
                controller.changeFontSize(value);
              }),
        ),
      ],
    );
  }
}

class _TodoSound extends StatelessWidget {
  const _TodoSound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextUtil(
            txt: 'Todo Sound', fontSize: 8.0.sp, fontWeight: FontWeight.normal),
        SizedBox(
          width: 3.0.wp,
        ),
        DoneAudioSwitcher(),
      ],
    );
  }
}

class _Fonts extends StatelessWidget {
  const _Fonts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextUtil(
            txt: 'fontLabel', fontSize: 8.0.sp, fontWeight: FontWeight.normal),
        SizedBox(
          width: 3.0.wp,
        ),
        FontSwitcher(),
      ],
    );
  }
}

class _Languages extends StatelessWidget {
  const _Languages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextUtil(
          txt: 'languageLabel'.tr,
          fontSize: 8.0.sp,
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        LanguagesSwitcher(),
      ],
    );
  }
}
