import 'package:flutter/material.dart';
import 'package:udhyog/models/press.dart';
import 'package:udhyog/providers/auth.dart';
import 'package:udhyog/providers/press.dart';
import 'package:udhyog/screens/auth.dart';
import 'package:udhyog/screens/login%20copy.dart';
import 'package:udhyog/screens/loginUp.dart';
import 'package:udhyog/screens/mainPage.dart';
import 'package:udhyog/screens/payment.dart';
import 'package:udhyog/screens/press_details.dart';
import 'package:udhyog/screens/splash_screen.dart';
import 'package:udhyog/screens/userDetails.dart';
import 'package:udhyog/widgets/newPress.dart';
import 'package:udhyog/widgets/slier.dart';
import 'package:udhyog/widgets/gauge.dart';

import './screens/login.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/screens/press_container.dart';

void main() {
  runApp(const MyApp());
}

//rzp_test_ovopv6bm1rGf6q //keyid
//MzVihCR05CyhFXF7ppliRYnw //keysecret
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ChangeNotifierProvider(
          //   create: (ctx) => PressProvider('', []),
          // ),
          ChangeNotifierProxyProvider<Auth, PressProvider>(
              update: (ctx, auth, previousState) => PressProvider(
                  auth.token.toString(),
                  previousState == null ? [] : previousState.presses),
              // PressProvider(auth.token!, previousState!.presses),
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
                    Payment.routeName: (ctx) => Payment(),
                    PressDetails.routeName: (ctx) => PressDetails(),
                    UserDetails.routeName: (ctx) => UserDetails()
                    //  AddPress.routeName:(ctx) => AddPress(),
                  },
                )));
  }
}
