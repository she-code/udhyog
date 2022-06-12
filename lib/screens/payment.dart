import 'package:flutter/material.dart';
import 'package:udhyog/screens/press_container.dart';
import 'package:udhyog/widgets/logoHeading.dart';

class Payment extends StatefulWidget {
  static String routeName = '/payment';
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          LogoHeading(),
          Center(
            child: ElevatedButton(
              child: Text("Done"),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(PressContainer.routeName);
              },
            ),
          )
        ],
      )),
    );
  }
}
