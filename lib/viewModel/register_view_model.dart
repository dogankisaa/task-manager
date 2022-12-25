import 'package:flutter/cupertino.dart';
import 'package:taskapp/service/auth.dart';

import 'package:taskapp/service/user_service.dart';
import 'package:taskapp/viewModel/base_view_model.dart';

class RegisterViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  @override
  Future<void> init() async {
    print("objectt");
  }

  register(BuildContext context) {
    print("object");
    AuthService().register(
        emailController.text,
        passwordController.text,
        nameController.text,
        surnameController.text,
        typeController.text,
        context);
  }
}
