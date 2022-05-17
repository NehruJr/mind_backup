import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../core/core.dart';
import '../../../data/models/task_model.dart';
import '../../../widgets/text_utils.dart';
import '../../detail/detail_view.dart';
import '../../settings/controllers/settings_controller.dart';
import '../controllers/home_controller.dart';

class TaskCard extends StatelessWidget {
  TaskCard({Key? key, required this.taskModel}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  final settingsCtr = Get.put<SettingsController>(SettingsController());
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(taskModel.color);
    final squareWidth = Get.width - 10.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(taskModel);
        homeCtrl.changeTodos(taskModel.todos ?? []);
        Get.to(
          () => DetailPage(),
          transition: Transition.leftToRightWithFade,
        );
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(2.0.wp),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 7,
                offset: const Offset(0, 7),
              ),
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homeCtrl.isTodosEmpty(taskModel)
                  ? 1
                  : taskModel.todos!.length,
              currentStep: homeCtrl.isTodosEmpty(taskModel)
                  ? 0
                  : homeCtrl.getDoneTodo(taskModel),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    IconData(taskModel.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  TextUtil(
                    txt: taskModel.priority.tr,
                    fontSize: 10.0.sp,
                    color: homeCtrl.priorityColor(taskModel.priority.tr),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 4.0.wp,
                  vertical: settingsCtr.fontSize.value == 3.0 &&
                          settingsCtr.langLocale.value == 'ar'
                      ? 2.0.wp
                      : 6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtil(
                    txt: taskModel.title,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0.sp,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2.0.wp,
                  ),
                  TextUtil(
                    txt: '${taskModel.todos?.length ?? 0} ' + 'Tasks'.tr,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 10.0.sp,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
