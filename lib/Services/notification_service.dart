import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/models/alarm_info_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(DateTime scheduledNotificationDateTime,
      AlarmInfo alarmInfo, BuildContext context) async {
    await flutterLocalNotificationsPlugin.schedule(
      1,
      alarmInfo.title,
      DateFormat('HH:mm').format(scheduledNotificationDateTime),
      scheduledNotificationDateTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
            'channel_two', 'Channel Two', 'Hello man',
            color: Colors.black,
            playSound: true,
            ongoing: true,
            enableLights: false,
            additionalFlags: Int32List.fromList(<int>[4]),
            fullScreenIntent: true,
            sound: RawResourceAndroidNotificationSound('birds'),
            importance: Importance.max,
            enableVibration: true,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher'),
        iOS: IOSNotificationDetails(
          sound: 'birds.mp3',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidAllowWhileIdle: true,
    );
  }

  Future<void> showNotificationaWithAlarmInfo(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'alarm', 'alarm', 'Channel for Alarm notification',
        color: Colors.black,
        playSound: true,
        ongoing: true,
        enableLights: true,
        additionalFlags: Int32List.fromList(<int>[4]),
        fullScreenIntent: true,
        sound: RawResourceAndroidNotificationSound('birds'),
        importance: Importance.max,
        enableVibration: true,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        sound: 'birds.mp3',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        alarmInfo.id,
        'Your alarm is up!',
        DateFormat('HH:mm').format(scheduledNotificationDateTime),
        tz.TZDateTime.now(tz.local)
            .add(Duration(seconds: scheduledNotificationDateTime.second)),
        platformChannelSpecifics,
        androidAllowWhileIdle: null,
        uiLocalNotificationDateInterpretation: null);
  }

  Future notificationSelected(BuildContext context, String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotifications(int index) async {
    await flutterLocalNotificationsPlugin.cancel(index);
  }
}
