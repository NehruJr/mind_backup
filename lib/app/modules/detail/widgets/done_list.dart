import 'package:mind_backup/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/storage/audioplayer.dart';
import '../../../widgets/text_utils.dart';
import '../../home/controllers/home_controller.dart';

class DoneList extends StatelessWidget {
  DoneList({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeCtrl.doneTodos.isEmpty
          ? Container()
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2.0.wp, horizontal: 5.0.wp),
                  child: TextUtil(
                    txt: 'Completed'.tr + ' (${homeCtrl.doneTodos.length})',
                    fontSize: 10.0.sp,
                    color: Colors.grey,
                  ),
                ),
                ...homeCtrl.doneTodos
                    .map((element) => Dismissible(
                          key: ObjectKey(element),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) {
                            AudioPlayerServices().deleteTodoAudio();
                            homeCtrl.deleteDoneTodo(element);
                          },
                          background: Container(
                            color: Colors.red.withOpacity(0.8),
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0.wp, horizontal: 9.0.wp),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Icons.done,
                                    color: kBlueColor,
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.0.wp, right: 4.0.wp),
                                    child: TextUtil(
                                      txt: element['title'],
                                      fontSize: 10.0.sp,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList()
              ],
            );
    });
  }
}
