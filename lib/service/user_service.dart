import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  addNewUser(name, email, type) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .set({"name": name, "email": email, "type": type});
  }
}
