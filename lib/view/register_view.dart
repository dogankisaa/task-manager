import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/view/login_view.dart';
import 'package:taskapp/viewModel/register_view_model.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    late RegisterViewModel viewModel;
    late BuildContext _context;

    return ChangeNotifierProvider.value(
      value: viewModel = RegisterViewModel(),
      builder: (context, child) {
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
                  height: 5,
                ),
                TextField(
                  controller: viewModel.nameController,
                  decoration: InputDecoration(
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: viewModel.surnameController,
                  decoration: InputDecoration(
                      hintText: "Surname",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: viewModel.passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: viewModel.typeController,
                  decoration: InputDecoration(
                      hintText: "Type",
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.grey))),
                ),
                ElevatedButton(
                    onPressed: () {
                      viewModel.register(context);
                    },
                    child: Center(
                      child: Text("Register"),
                    )),
                InkWell(
                    onTap: () => Grock.to(LoginView()), child: Text("Login")),
              ],
            ),
          )),
        );
      },
    );
  }
}
