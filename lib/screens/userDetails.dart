import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class UserDetails extends StatelessWidget {
  static String routeName = '/userInfo';

  @override
  Widget build(BuildContext context) {
    final company = Provider.of<Auth>(context, listen: false).company;
    final city = Provider.of<Auth>(context, listen: false).company;

    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(radius: 50, child: Icon(Icons.person)),
                  Text(
                    company.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            height: 250,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(80)),
              //BorderRadiusDirectional.only(
              //     bottomEnd: Radius.circular(50),
              //     bottomStart: Radius.circular(50)),
              gradient: LinearGradient(
                colors: [Colors.green, Colors.orange],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.email),
                  Text("Email", style: TextStyle(color: Colors.grey))
                ]),
                Text(
                  "Fre@gmail.com",
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.phone),
                  Text("Phone", style: TextStyle(color: Colors.grey))
                ]),
                Text(
                  "9099466257",
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.person),
                  Text("Contact Person", style: TextStyle(color: Colors.grey))
                ]),
                Text(
                  "Amit Sata",
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.home),
                  Text("Address", style: TextStyle(color: Colors.grey))
                ]),
                Text(
                  "Morbi Road",
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.home),
                  Text("GST", style: TextStyle(color: Colors.grey))
                ]),
                Text(
                  "GHHKKHLA69688",
                ),
              ],
            ),
            height: 80,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey.shade400)),
          ),
        ],
      ),
    ));
  }
}
