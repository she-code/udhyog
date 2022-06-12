import 'package:flutter/material.dart';

class MainFooter extends StatelessWidget {
  const MainFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
            height: 50,
            child: Column(
              children: [
                Text(
                  "Copyright @ 2020".toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
                Text(
                  'udhyog'.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                )
              ],
            )),
      ),
    );
  }
}
