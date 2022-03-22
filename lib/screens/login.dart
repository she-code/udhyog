// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:udhyog/screens/mainPage.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path starts with (0.0, 0.0) point (1)
    path.lineTo(0.0, size.height - 90);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 200);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const routeName = '/login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Color background = Color(0xFFEEF3FA);
    Color textFcolor = Color(0xFFE7EEF5);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text("Udhyog"),
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
        body: Container(
      width: deviceSize.width,
      height: deviceSize.height,
      padding: EdgeInsets.all(0),
      color: background,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              //alignment: Alignment.centeRight,
              width: 250,
              height: 200,
              decoration: BoxDecoration(color: Colors.green),
              //  child: Text('LOGIN'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Text("Logo"),
                // const SizedBox(
                //   height: 15,
                // ),
                Text(
                  "Welcome".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  decoration: BoxDecoration(boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 16,
                      offset: Offset(-2, -9),
                    ),
                  ]),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.lightGreen,
                      ),
                      filled: true,
                      fillColor: textFcolor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      label: const Text(
                        "Username",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    controller: username,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: 350,
                  decoration: const BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 16,
                      offset: Offset(-2, -9),
                    ),
                  ]),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.password_outlined,
                        color: Colors.lightGreen,
                      ),
                      filled: true,
                      fillColor: textFcolor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      label: const Text(
                        "Password",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    controller: password,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    child: Text(
                      "Sign in".toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(MainPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 15,
                      shadowColor: Colors.orangeAccent.shade700,
                      padding: EdgeInsets.all(20),
                      primary: Colors.orangeAccent.shade700,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
