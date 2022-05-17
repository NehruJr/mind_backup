import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../../data/models/task_model.dart';
import '../../../widgets/text_utils.dart';
import '../../report/report_view.dart';
import '../controllers/home_controller.dart';
import '../widgets/add_card.dart';
import '../widgets/add_dialog.dart';
import '../widgets/task_card.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(index: controller.tabIndex.value, children: [
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(4.0.wp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUtil(
                          txt: 'My List',
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold),
                      IconButton(
                          onPressed: () {
                            Get.toNamed('/settings');
                          },
                          icon: const Icon(Icons.settings_outlined))
                    ],
                  ),
                ),
                Obx(() {
                  return GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks
                          .where((p0) => p0.priority.tr == 'High'.tr)
                          .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(taskModel: element),
                              ),
                              child: Visibility(
                                  visible: !controller.isDragging.value,
                                  child: TaskCard(taskModel: element))))
                          .toList(),
                      ...controller.tasks
                          .where((p0) => p0.priority.tr == 'Medium'.tr)
                          .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(taskModel: element),
                              ),
                              child: Visibility(
                                  visible: !controller.isDragging.value,
                                  child: TaskCard(taskModel: element))))
                          .toList(),
                      ...controller.tasks
                          .where((p0) => p0.priority.tr == 'Low'.tr)
                          .map((element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () =>
                                  controller.changeDeleting(true),
                              onDraggableCanceled: (_, __) =>
                                  controller.changeDeleting(false),
                              onDragEnd: (_) =>
                                  controller.changeDeleting(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: TaskCard(taskModel: element),
                              ),
                              child: Visibility(
                                  visible: !controller.isDragging.value,
                                  child: TaskCard(taskModel: element))))
                          .toList(),
                      Visibility(
                          visible: !controller.isDragging.value,
                          child: AddCard())
                    ],
                  );
                }),
              ],
            ),
          ),
          ReportPage(),
        ]);
      }),
      floatingActionButton: DragTarget<TaskModel>(
        builder: (_, __, ___) {
          return Obx(() {
            return FloatingActionButton(
              backgroundColor:
                  controller.deleting.value ? Colors.red : kBlueColor,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo(
                    'createWarning'.tr,
                  );
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            );
          });
        },
        onAccept: (TaskModel task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Success'.tr);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(() {
          return BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.0.wp),
                    child: const Icon(Icons.apps),
                  )),
              BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.0.wp),
                    child: const Icon(Icons.data_usage),
                  )),
            ],
          );
        }),
      ),
    );
  }
}
