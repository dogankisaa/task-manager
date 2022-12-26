import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:taskapp/view/task_detail_view.dart';

class NotificationService {
  late FirebaseMessaging messaging = FirebaseMessaging.instance;

  void settingNotification() async {
    await messaging.requestPermission(alert: true, sound: true, badge: true);
  }

  void navigateToTask() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Grock.to(TaskDetailView());
    });
  }

  void connetctNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);

    settingNotification();
    navigateToTask();

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Grock.snackBar(
          title: "${event.notification!.title}",
          description: "${event.notification!.body}");
    });
  }

  getFcm() async {
    String? token = await FirebaseMessaging.instance.getToken();

    return token;
  }
}
