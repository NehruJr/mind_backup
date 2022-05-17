import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsServices extends GetxService {
  @override
  void onInit() async {
    awesomeNotificationInit();
    super.onInit();
  }

  awesomeNotificationInit() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          defaultColor: Colors.teal,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: '',
        ),
      ],
    );
  }
}
