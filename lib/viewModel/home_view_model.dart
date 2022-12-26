import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskapp/core/helper/bottom_sheet.dart';
import 'package:taskapp/service/auth.dart';
import 'package:taskapp/service/task_service.dart';
import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/viewModel/base_view_model.dart';
import 'package:intl/intl.dart';

import '../service/notification_service.dart';

class HomeViewModel extends BaseViewModel {
  DateTime startTime = DateTime.now();
  DateTime dueTime = DateTime.now();
  bool isTimeValid = false;
  String fcm = "";
  Stream<DocumentSnapshot>? taskSnapshot;
  String? userName, userType;
  bool isManager = false;
  List asignedUsers = [];
  TextEditingController taskTitleController = TextEditingController();

  TextEditingController assignedUsersController = TextEditingController();

  @override
  Future<void> init() async {
    getName();
    getType();

    NotificationService().connetctNotification();
  }

  getName() async {
    userName = await UserService().getUserData("name");
    return userName;
  }

  getType() async {
    userType = await UserService().getUserData("type");
    print(userType);
    userType == "Manager" ? isManager = !isManager : null;
    print(isManager);
    notifyListeners();
  }

  newTaskBottomSheetOpener(BuildContext context, Widget body) {
    bottomSheet(context, body);
  }

  addAsignedUser() {
    asignedUsers.add(assignedUsersController.text);
  }

  addNewTask() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("date");
    print({startTime.month + startTime.day + startTime.hour});
    TaskService().addNewTask(
        token,
        taskTitleController.text,
        DateFormat.MMMMEEEEd().format(startTime),
        DateFormat.MMMMEEEEd().format(dueTime),
        asignedUsers);
  }

  setStartTime(time) {
    print(startTime);
    return startTime = time;
  }

  setDueTime(time) {
    dueTime = time;
  }

  timeCompore() {
    print(startTime);
    print(dueTime);
    dueTime.isBefore(startTime) ? isTimeValid = true : isTimeValid = false;
  }
}
