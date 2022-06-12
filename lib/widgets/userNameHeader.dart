import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class UserNameHeader extends StatelessWidget {
  const UserNameHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color greenLight = Color(0xff63d47a);
    final deviceSize = MediaQuery.of(context).size;
    final company = Provider.of<Auth>(context, listen: false).company;
    final city = Provider.of<Auth>(context, listen: false).city;
    //final logo = Provider.of<Auth>(context, listen: false).logo ?? "";

    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: greenLight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                company.isEmpty
                    ? "Hello"
                    : '${company.toUpperCase()} - ${city.toUpperCase()}',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            // CircleAvatar(
            //   backgroundImage: NetworkImage(logo),
            // )
          ],
        ));
  }
}
