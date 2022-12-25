import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/view/login_view.dart';

import '../view/home_view.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  register(email, password, name, surname, type, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        UserService().addNewUser(name, email, type);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  login(email, password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
