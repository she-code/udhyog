import 'package:flutter/material.dart';

class LogoHeading extends StatelessWidget {
  const LogoHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Image.asset(
                'assets/images/mainLogo.png',
                width: 100,
                height: 100,
              ),
            ),
            Container(
              child: Image.asset(
                'assets/images/loginLogo.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
