import 'package:flutter/material.dart';

class PressList extends StatelessWidget {
  final String pressName;
  PressList(this.pressName);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 2),
        child: Text(
          pressName,
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white,
          // boxShadow: [BoxShadow()])
        ));
  }
}
