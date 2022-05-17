import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../core/core.dart';
import '../../widgets/text_utils.dart';
import '../home/controllers/home_controller.dart';
import 'widgets/doing_list.dart';
import 'widgets/done_list.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();

  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    var color = HexColor.fromHex(task!.color);
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
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.editController.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                          IconData(task.icon, fontFamily: 'MaterialIcons'),
                        color: color,
                      ),
                      SizedBox(
                        width: 3.0.wp,
                      ),
                      Flexible(
                        child: TextUtil(
                          txt: task.title,
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.0.wp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 9.0.wp, right: 8.0.wp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextUtil(
                          txt: task.taskDate,
                          fontSize: 8.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        TextUtil(
                            txt: task.priority.tr,
                            fontSize: 8.0.sp,
                            fontWeight: FontWeight.bold,
                            color: homeCtrl.priorityColor(task.priority.tr)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
              return Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 6.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    TextUtil(
                      txt: '$totalTodos ' + 'Tasks'.tr,
                      fontSize: 9.0.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 30.0.wp,
                    ),
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeCtrl.doneTodos.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color]),
                      unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!]),
                    )),
                  ],
                ),
              );
            }),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 4.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editController,
                decoration: InputDecoration(
                  hintText: 'Add new task'.tr,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  prefixIcon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.grey[400]!,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        var success =
                            homeCtrl.addTodo(homeCtrl.editController.text);
                        if (success) {
                          EasyLoading.showSuccess(
                              'Todo item added successfully'.tr);
                        } else {
                          EasyLoading.showError('Todo item already exist'.tr);
                        }
                        homeCtrl.editController.clear();
                      }
                    },
                    icon: const Icon(Icons.done),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item'.tr;
                  } else {
                    return null;
                  }
                },
              ),
            ),
            DoingList(),
            DoneList(),
          ],
        ),
      )),
    );
  }
}
