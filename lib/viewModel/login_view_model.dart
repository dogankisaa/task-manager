import 'package:flutter/cupertino.dart';
import 'package:taskapp/service/auth.dart';
import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/viewModel/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  String? userName;
  @override
  Future<void> init() async {}

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(context) {
    AuthService().login(emailController.text, passwordController.text, context);
  }
}
