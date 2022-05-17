import 'package:mind_backup/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../widgets/text_utils.dart';
import '../controllers/home_controller.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          homeCtrl.editController.clear();
                          homeCtrl.changeTask(null);
                        },
                        icon: const Icon(Icons.close)),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          if (homeCtrl.formKey.currentState!.validate()) {
                            if (homeCtrl.task.value == null) {
                              EasyLoading.showError('taskType'.tr);
                            } else {
                              var success = homeCtrl.updateTask(
                                  homeCtrl.task.value!,
                                  homeCtrl.editController.text);
                              if (success) {
                                EasyLoading.showSuccess('todoSuccess'.tr);
                                Get.back();
                                homeCtrl.changeTask(null);
                              } else {
                                EasyLoading.showError('todoExist'.tr);
                              }
                              homeCtrl.editController.clear();
                            }
                          }
                        },
                        child: TextUtil(
                          txt: 'Done',
                          color: kLightBlueColor,
                          fontSize: 12.0.sp,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextUtil(
                  txt: 'New Task',
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'todoValidate'.tr;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: TextUtil(
                  txt: 'Add to',
                  fontSize: 12.0.sp,
                  color: Colors.grey,
                ),
              ),
              ...homeCtrl.tasks
                  .map((element) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0.wp, vertical: 3.0.wp),
                        child: Obx(() {
                          return InkWell(
                            onTap: () {
                              homeCtrl.changeTask(element);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      IconData(element.icon,
                                          fontFamily: 'MaterialIcons'),
                                      color: HexColor.fromHex(element.color),
                                    ),
                                    SizedBox(
                                      width: 3.0.wp,
                                    ),
                                    TextUtil(
                                      txt: element.title,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                if (homeCtrl.task.value == element)
                                  const Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  ),
                              ],
                            ),
                          );
                        }),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
