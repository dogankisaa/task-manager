import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taskapp/service/auth.dart';
import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/viewModel/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String? userName;
  @override
  Future<void> init() async {
    getName();
  }

  getName() async {
    userName = await UserService().getUserName();
    return userName;
    notifyListeners();
  }
}
