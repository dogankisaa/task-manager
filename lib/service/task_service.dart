import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference tasksRef = FirebaseFirestore.instance.collection('tasks');

  addNewTask(title, start, due, asignedUsers) {
    FirebaseFirestore.instance.collection("tasks").doc().set({
      "title": title,
      "startTime": start,
      "dueTime": due,
      "asignedUsers": asignedUsers
    });
  }

  getPersonalTasks() {
    var personalTasksRef =
        tasksRef.where("asignedUsers", arrayContains: auth.currentUser!.email);
    print(auth.currentUser!.email);
    print(personalTasksRef);
    return personalTasksRef;
  }
}
