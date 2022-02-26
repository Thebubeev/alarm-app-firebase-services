import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_rays7c/Services/notification_service.dart';
import 'package:flutter_alarm_rays7c/auth_layout/forgot_page.dart';
import 'package:flutter_alarm_rays7c/auth_layout/login_page.dart';
import 'package:flutter_alarm_rays7c/auth_layout/register_page.dart';
import 'package:flutter_alarm_rays7c/auth_layout/wrapper_page.dart';
import 'package:flutter_alarm_rays7c/config/my_app.dart';
import 'package:flutter_alarm_rays7c/home_layout/home_page.dart';
import 'package:flutter_alarm_rays7c/auth_layout/provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationFunctions>(
      create: (_) => NotificationFunctions(),
      child: MaterialApp(
        routes: {
          '/signUp': (context) => RegisterPage(),
          '/signIn': (context) => LoginPage(),
          '/wrapper': (context) => Wrapper(),
          '/forgot': (context) => ForgotPassword(),
          '/home': (context) => HomeLayout()
        },
        title: 'Flutter Demo',
        home: AuthPage(),
      ),
    );
  }
}
