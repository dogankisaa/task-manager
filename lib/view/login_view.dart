import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/view/register_view.dart';
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                ElevatedButton(
                    onPressed: () {
                      viewModel.login(context);
                    },
                    child: Center(
                      child: Text("Login"),
                    )),
                InkWell(
                    onTap: () => Grock.to(RegisterView()),
                    child: Text("Register"))
              ],
            ),
          )),
        );
      },
    );
  }
}
