import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  addNewUser(name, email, type) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .set({"name": name, "email": email, "type": type});
  }

  getUserData(parameter) async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.currentUser!.email)
        .get();

    return data.data()?[parameter];
  }
}
