import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';
import '../../../data/models/task_model.dart';
import '../../../widgets/text_utils.dart';
import '../controllers/home_controller.dart';
import '../icons.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final homeCtr = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.dialog(
            Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 1.0.wp, vertical: 22.0.hp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Form(
                    key: homeCtr.formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0.wp),
                            child: TextUtil(
                                txt: 'New Task'.tr,
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: homeCtr.editController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Title'.tr,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'titleValidate'.tr;
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 7.0.wp,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: (squareWidth / 2) - 15,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: kLightGreyColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2.0.wp),
                                  child:
                                      GetBuilder<HomeController>(builder: (_) {
                                    return _buildSelectTaskDateContainer(
                                        context);
                                  }),
                                ),
                              ),
                              Obx(() {
                                return _buildPriorityContainer(squareWidth);
                              }),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                            child: Wrap(
                              spacing: 2.0.wp,
                              children: icons
                                  .map((e) => Obx(() {
                                        final index = icons.indexOf(e);
                                        return ChoiceChip(
                                          selectedColor: kLightGreyColor,
                                          pressElevation: 0,
                                          backgroundColor: Colors.white,
                                          label: e,
                                          selected:
                                              homeCtr.chipIndex.value == index,
                                          onSelected: (bool selected) {
                                            homeCtr.chipIndex.value =
                                                selected ? index : 0;
                                          },
                                        );
                                      }))
                                  .toList(),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kBlueColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                minimumSize: const Size(150, 40),
                              ),
                              onPressed: () {
                                if (homeCtr.formKey.currentState!.validate()) {
                                  int icon = icons[homeCtr.chipIndex.value]
                                      .icon!
                                      .codePoint;
                                  String color = icons[homeCtr.chipIndex.value]
                                      .color!
                                      .toHex();
                                  var task = TaskModel(
                                      title: homeCtr.editController.text,
                                      icon: icon,
                                      taskDate: DateFormat("d MMMM y")
                                          .format(homeCtr.taskTime),
                                      priority: homeCtr.selectedPriority.value,
                                      color: color);
                                  Get.back();
                                  homeCtr.addTask(task)
                                      ? EasyLoading.showSuccess(
                                          'Create Success')
                                      : EasyLoading.showError(
                                          'Duplicated Task');
                                }
                              },
                              child: TextUtil(
                                txt: 'Confirm'.tr,
                                fontSize: 10.0.sp,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )),
              ),
            ),
          );
          homeCtr.editController.clear();
          homeCtr.taskTime = DateTime.now();
          homeCtr.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSelectTaskDateContainer(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDatePicker(
          context: context,
          initialDate: homeCtr.taskTime,
          lastDate: DateTime(2100, 1),
          firstDate: DateTime.now(),
        ).then((value) {
          if (value != null) {
            homeCtr.changeSelectedTime(value);
          }
        });
      },
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: const Icon(Icons.date_range_outlined),
            ),
            decoration: BoxDecoration(
              color: kLightGreyColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            width: 2.0.wp,
          ),
          Text(DateFormat("MMMM d").format(homeCtr.taskTime)),
        ],
      ),
    );
  }

  Container _buildPriorityContainer(double squareWidth) {
    return Container(
      width: (squareWidth / 2) - 15,
      decoration: BoxDecoration(
        color: homeCtr.priorityColor(homeCtr.selectedPriority.value),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: homeCtr.selectedPriority.value == 'Low'
                    ? const Icon(
                        Icons.low_priority,
                        color: Colors.blue,
                      )
                    : homeCtr.selectedPriority.value == 'Medium'
                        ? const Icon(
                            Icons.priority_high,
                            color: Colors.orange,
                          )
                        : const Icon(
                            Icons.local_fire_department,
                            color: Colors.red,
                          ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              width: 2.0.wp,
            ),
            Expanded(
              child: _buildDropdownButtonFormField(),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButtonFormField<String> _buildDropdownButtonFormField() {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            label: Text(
              'Priority'.tr,
              style: TextStyle(color: Colors.black.withOpacity(0.5)),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color:
                        homeCtr.priorityColor(homeCtr.selectedPriority.value))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: homeCtr
                        .priorityColor(homeCtr.selectedPriority.value)))),
        focusColor: Colors.black45,
        value: homeCtr.selectedPriority.value,
        items: homeCtr.listOfValue.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val.tr,
            ),
          );
        }).toList(),
        onChanged: (value) {
          homeCtr.selectedPriority.value = value.toString();
        });
  }
}
