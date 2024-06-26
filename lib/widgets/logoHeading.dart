import 'package:flutter/material.dart';

class LogoHeading extends StatelessWidget {
  const LogoHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset(
                'assets/images/mainLogo.png',
                width: 80,
                height: 80,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/images/loginLogo.png',
                width: 80,
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
