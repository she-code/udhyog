import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/screens/register.dart';

import './providers/auth.dart';
import './providers/press.dart';
import './screens/auth.dart';
import './screens/mainPage.dart';
import './screens/payment.dart';
import './screens/pdfPriview.dart';
import './screens/press_details.dart';
import './screens/splash_screen.dart';
import './screens/userDetails.dart';
import './screens/newPress.dart';
import './screens/press_container.dart';

void main() {
  runApp(MyApp());
}

//rzp_test_ovopv6bm1rGf6q //keyid
//MzVihCR05CyhFXF7ppliRYnw //keysecret
class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  Color greenLight = Color(0xff63d47a);
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
                      primaryColor: Colors.green,
                      primaryColorDark: Colors.green[800],
                      primaryColorLight: greenLight,
                      colorScheme: ThemeData.light().colorScheme.copyWith(
                          secondary: Colors.orange,
                          primary: Colors.green,
                          error: Colors.red)),
                  home: auth.isAuth
                      ? MainPage()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()

                                  ///: authResultSnapshot.data == false
                                  : const AuthPage()
                          // : MainPage(),
                          ),
                  // initialRoute: '/login',
                  routes: {
                    '/main': (ctx) => MainPage(),
                    PressContainer.routeName: (ctx) => PressContainer(),
                    NewPress.routeName: (ctx) => NewPress(),
                    Payment.routeName: (ctx) => Payment(),
                    PressDetails.routeName: (ctx) => PressDetails(),
                    UserDetails.routeName: (ctx) => UserDetails(),
                    Register.routeName: (ctx) => Register(),
                    PdfPreviewPage.routeName: (ctx) => PdfPreviewPage()
                    //  AddPress.routeName:(ctx) => AddPress(),
                  },
                )));
  }
}
