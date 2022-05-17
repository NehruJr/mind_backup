import 'package:mind_backup/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../data/providers/notifications_provider.dart';
import '../../../data/services/storage/audioplayer.dart';
import '../../../widgets/text_utils.dart';
import '../../home/controllers/home_controller.dart';

class DoingList extends StatelessWidget {
  DoingList({Key? key}) : super(key: key);
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeCtr.doingTodos.isEmpty && homeCtr.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/notask.png',
                  fit: BoxFit.cover,
                  width: 65.0.wp,
                ),
                SizedBox(
                  height: 3.0.hp,
                ),
                TextUtil(
                  txt: 'No tasks on horizon!',
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 1.0.hp,
                ),
                TextUtil(
                    txt: 'Add a task or enjoy your day off',
                    fontSize: 10.0.sp,
                    color: Colors.black.withOpacity(0.6)),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtr.doingTodos
                    .map((element) => Slidable(
                          key: ObjectKey(element),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                flex: 1,
                                onPressed: (__) async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData(
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary: kBlueColor,
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                          lastDate: DateTime(2100, 1))
                                      .then((value) => homeCtr
                                          .changeSelectedReminderDate(value!))
                                      .then((value) async => homeCtr
                                              .timeOfReminder =
                                          (await showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay.fromDateTime(
                                                DateTime.now().add(
                                                  const Duration(minutes: 1),
                                                ),
                                              ),
                                              builder: (BuildContext context,
                                                  Widget? child) {
                                                return Theme(
                                                  data: ThemeData(
                                                    colorScheme:
                                                        const ColorScheme.light(
                                                      primary: kBlueColor,
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              }))!)
                                      .then((value) => NotificationsProvider()
                                          .createTodoReminderNotification(
                                              element['title'],
                                              homeCtr.dateOfReminder,
                                              homeCtr.timeOfReminder));
                                },
                                backgroundColor: Colors.green[500]!,
                                foregroundColor: Colors.white,
                                icon: Icons.alarm,
                                label: 'Reminder'.tr,
                              ),
                              SlidableAction(
                                flex: 1,
                                onPressed: (__) {
                                  homeCtr.deleteDoingTodo(element);
                                  AudioPlayerServices().deleteTodoAudio();
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete'.tr,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 3.0.wp, horizontal: 9.0.wp),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) => Colors.grey),
                                    value: element['done'],
                                    onChanged: (value) {
                                      homeCtr.doneTodo(element['title']);
                                      AudioPlayerServices().doneTodoAudio();
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 4.0.wp, right: 4.0.wp),
                                    child: TextUtil(
                                      txt: element['title'],
                                      fontSize: 10.0.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                if (homeCtr.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            );
    });
  }
}
