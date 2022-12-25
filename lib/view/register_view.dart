import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: viewModel.emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              TextField(
                controller: viewModel.nameController,
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: viewModel.surnameController,
                decoration: InputDecoration(hintText: "Surname"),
              ),
              TextField(
                controller: viewModel.passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              TextField(
                controller: viewModel.typeController,
                decoration: InputDecoration(hintText: "Type"),
              ),
              ElevatedButton(
                  onPressed: () {
                    viewModel.register(context);
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
