import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class NotificationsProvider {
  int createUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

  Future<void> createTodoReminderNotification(
      String todo, DateTime date, TimeOfDay time) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: '${Emojis.time_alarm_clock} Don\'t forget your task',
        body: todo,
        notificationLayout: NotificationLayout.Default,
        color: kBlueColor,
      ),
      actionButtons: [
        NotificationActionButton(
          color: kBlueColor,
          key: 'MARK_DONE',
          label: 'I am on it',
        ),
      ],
      schedule: NotificationCalendar(
        year: date.year,
        month: date.month,
        day: date.day,
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
      ),
    );
  }
}
