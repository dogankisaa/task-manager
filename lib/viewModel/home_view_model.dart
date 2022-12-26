import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskapp/core/helper/bottomSheet.dart';
import 'package:taskapp/service/auth.dart';
import 'package:taskapp/service/task_service.dart';
import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/viewModel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  CollectionReference taskRef = FirebaseFirestore.instance.collection("tasks");
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

  addNewTask() {
    TaskService()
        .addNewTask(taskTitleController.text, "start", "due", asignedUsers);
  }

  getTaskList() async {
    taskSnapshot = await TaskService().getAllTasks();
    return taskSnapshot;
  }
}
