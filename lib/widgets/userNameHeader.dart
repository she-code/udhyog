import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/userDetails.dart';

import '../providers/auth.dart';

class UserNameHeader extends StatefulWidget {
  const UserNameHeader({Key? key}) : super(key: key);

  @override
  State<UserNameHeader> createState() => _UserNameHeaderState();
}

class _UserNameHeaderState extends State<UserNameHeader> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var token = SharedPreferences.getInstance();
    // final extractedUserData =
    //       json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    Color greenLight = Color(0xff63d47a);
    final deviceSize = MediaQuery.of(context).size;
    final company = Provider.of<Auth>(context, listen: false).company == null
        ? "F"
        : Provider.of<Auth>(context, listen: false).company;
    final city = Provider.of<Auth>(context, listen: false).city;
    //final logo = Provider.of<Auth>(context, listen: false).logo ?? "";
    // final logo = Provider.of<Auth>(context, listen: false).logo;

    return Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: greenLight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: ModalRoute.of(context)?.settings.name == '/'
                  ? SizedBox()
                  : IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 16,
                      )),
            ),
            Text(
                company!.isEmpty
                    ? "Hello"
                    : '${company.toUpperCase()} - ${city!.toUpperCase()}',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            GestureDetector(
              onTap: () {
                if (ModalRoute.of(context)?.settings.name ==
                    UserDetails.routeName) {
                  Navigator.of(context).pop();
                }
                Navigator.of(context).pushNamed(UserDetails.routeName,
                    arguments:
                        Provider.of<Auth>(context, listen: false).userId);
              },
              child: Container(
                margin: EdgeInsets.only(right: 30),
                child: CircleAvatar(
                  radius: 20,
                  child: Text(company.substring(0, 1).toUpperCase()),
                  // backgroundImage: NetworkImage(logo),
                ),
              ),
            )
          ],
        ));
  }
}
