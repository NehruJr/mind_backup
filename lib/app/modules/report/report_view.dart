import 'package:mind_backup/app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:intl/intl.dart';

import '../../widgets/text_utils.dart';
import '../home/controllers/home_controller.dart';

class ReportPage extends StatelessWidget {
  ReportPage({Key? key}) : super(key: key);
  final homeCtrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeCtrl.getTotalTask();
        var completedTasks = homeCtrl.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percent = (completedTasks / createdTasks * 100).toStringAsFixed(0);
        return ListView(
          children: [
            SizedBox(
              height: 2.0.wp,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 2.0.wp),
              child: TextUtil(
                  txt: 'My Report'.tr,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: TextUtil(
                txt: DateFormat.yMMMMd().format(DateTime.now()),
                fontSize: 9.0.sp,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 3.0.wp, horizontal: 4.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                  _buildStatus(Colors.orange, completedTasks, 'Completed'),
                  _buildStatus(Colors.blue, createdTasks, 'Created'),
                ],
              ),
            ),
            SizedBox(
              height: 8.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 70.0.wp,
                height: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: completedTasks,
                  stepSize: 20,
                  selectedColor: kGreenColor,
                  unselectedColor: Colors.grey[200],
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextUtil(
                        txt: '${createdTasks == 0 ? 0 : percent} %',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0.sp,
                      ),
                      SizedBox(
                        height: 1.0.wp,
                      ),
                      TextUtil(
                        txt: 'Efficiency',
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 9.0.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 0.5.wp, color: color),
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUtil(
              txt: '$number',
              fontWeight: FontWeight.bold,
              fontSize: 12.0.sp,
            ),
            SizedBox(
              height: 2.0.wp,
            ),
            TextUtil(
              txt: text,
              fontSize: 9.0.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
