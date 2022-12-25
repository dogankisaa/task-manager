import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  CollectionReference users = FirebaseFirestore.instance.collection('tasks');
  FirebaseAuth auth = FirebaseAuth.instance;

  addNewTask(title, start, due, asignedUsers) {
    FirebaseFirestore.instance.collection("tasks").doc().set({
      "title": title,
      "startTime": "start",
      "dueTime": "due",
      "asignedUsers": asignedUsers
    });
  }
}
