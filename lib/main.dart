import 'package:flutter/material.dart';
import 'package:udhyog/models/press.dart';
import 'package:udhyog/providers/auth.dart';
import 'package:udhyog/providers/press.dart';
import 'package:udhyog/screens/auth.dart';
import 'package:udhyog/screens/login%20copy.dart';
import 'package:udhyog/screens/loginUp.dart';
import 'package:udhyog/screens/mainPage.dart';
import 'package:udhyog/screens/splash_screen.dart';
import 'package:udhyog/widgets/newPress.dart';
import 'package:udhyog/widgets/slier.dart';
import 'package:udhyog/widgets/gauge.dart';

import './screens/login.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/screens/press_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, PressProvider>(
              update: (ctx, auth, previousState) =>
                  PressProvider(auth.token!, previousState!.presses),
              create: (_) => PressProvider('', []))
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Udhyog',
                  theme: ThemeData(
                      primarySwatch: Colors.green,
                      colorScheme: ThemeData.light()
                          .colorScheme
                          .copyWith(secondary: Colors.orange)),
                  home: auth.isAuth
                      ? MainPage()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : const AuthPage(),
                        ),
                  // initialRoute: '/login',
                  routes: {
                    '/main': (ctx) => MainPage(),
                    PressContainer.routeName: (ctx) => PressContainer(),
                    NewPress.routeName: (ctx) => NewPress(),
                    //  AddPress.routeName:(ctx) => AddPress(),
                  },
                )));
  }
}
