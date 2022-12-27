import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/service/notification_service.dart';
import 'package:taskapp/view/home_view.dart';
import 'package:taskapp/view/login_view.dart';
import 'package:taskapp/view/register_view.dart';
import 'package:taskapp/viewModel/home_view_model.dart';
import 'package:taskapp/viewModel/login_view_model.dart';
import 'package:taskapp/viewModel/register_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(),
    ),
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
      builder: (context, child) => const MyApp(),
    ),
  ]));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Grock.navigationKey,
        scaffoldMessengerKey: Grock.scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: userCheck());
  }

  initNotification() {
    NotificationService().connetctNotification();
  }
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
