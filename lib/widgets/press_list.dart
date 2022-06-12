import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class Press_List extends StatelessWidget {
  final String pressName;
  Press_List(this.pressName);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 2),
        child: Text(
          StringUtils.capitalize(pressName),
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white,
          // boxShadow: [BoxShadow()])
        ));
  }
}
