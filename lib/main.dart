import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

import 'Services/firebase_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    MessagingService.initialize(onSelectNotification).then(
      (value) => firebaseCloudMessagingListeners(),
    );
    super.initState();
  }

  void firebaseCloudMessagingListeners() async {
    MessagingService.onMessage.listen(MessagingService.invokeLocalNotification);
    MessagingService.onMessageOpenedApp.listen(_pageOpenForOnLaunch);
  }

  _pageOpenForOnLaunch(RemoteMessage remoteMessage) {
    final Map<String, dynamic> message = remoteMessage.data;
    onSelectNotification(jsonEncode(message));
  }

  Future onSelectNotification(String payload) async {
    print(payload);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationFunctions>(
      create: (_) => NotificationFunctions(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/signUp': (context) => RegisterPage(),
          '/signIn': (context) => LoginPage(),
          '/wrapper': (context) => Wrapper(),
          '/forgot': (context) => ForgotPassword(),
          '/home': (context) => HomeLayout()
        },
        initialRoute: '/home',
        title: 'Flutter Demo',
        home: AuthPage(),
      ),
    );
  }
}
