import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          child: Text(
            'Cooking ',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).secondaryHeaderColor),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Your Account"),
          onTap: () {},
        )
      ],
    ));
  }
}
