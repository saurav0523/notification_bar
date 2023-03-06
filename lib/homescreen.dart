import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:developer';
import 'package:saurav111/main.dart';

import 'main.dart';

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  void shownotification() async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      "notification-youtube",
      "Youtube Notification",
      priority: Priority.max,
      importance: Importance.max,
    );

    DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    DateTime scheduleDate = DateTime.now().add(Duration(seconds: 2));
    for (int i = 0; i < 10; i++) {
      await notificationsPlugin.show(
          0,
          "Saurav  ",
          "This is my first project",
          // tz.TZDateTime.from(scheduleDate, tz.local),
          notDetails,
          // uiLocalNotificationDateInterpretation:
          //     UILocalNotificationDateInterpretation.wallClockTime,
          // androidAllowWhileIdle: true,
          payload: "notification-payload");
      await Future.delayed(Duration(seconds: 5));
    }
  }

  void checkforNotification() async {
    NotificationAppLaunchDetails? details =
        await notificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null) {
      if (details.didNotificationLaunchApp) {
        NotificationResponse? response = details.notificationResponse;

        if (response != null) {
          String? payload = response.payload;
          log("Notification Payload : $payload");
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkforNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: shownotification,
        child: Icon(Icons.notification_add),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
