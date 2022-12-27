import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/home_view.dart';
import '../view/login_view.dart';

abstract class BaseViewModel with ChangeNotifier {
  BaseViewModel() {
    init();
  }
  Future<void> init() async {
    userCheck();
  }

  userCheck() {
    print("object");
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) {
      return LoginView();
    } else {
      return HomeView();
    }
  }
}
