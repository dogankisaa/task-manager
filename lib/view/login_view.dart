import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/viewModel/login_view_model.dart';
import 'package:taskapp/viewModel/register_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    late LoginViewModel viewModel;
    late BuildContext _context;

    return ChangeNotifierProvider.value(
      value: viewModel = LoginViewModel(),
      builder: (context, child) {
        print(viewModel.userName);
        return Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: viewModel.emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: viewModel.passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.login(context);
                  },
                  child: Center(
                    child: Text("Register"),
                  ))
            ],
          )),
        );
      },
    );
  }
}
