import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/view/register_view.dart';
import 'package:taskapp/viewModel/login_view_model.dart';
import 'package:taskapp/viewModel/register_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
      builder: (context, child) => const MyApp(),
    ),
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
      builder: (context, child) => const MyApp(),
    ),
  ]));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RegisterView(),
    );
  }
}
