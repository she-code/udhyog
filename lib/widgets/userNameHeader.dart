import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth.dart';
import '../screens/userDetails.dart';

import '../providers/auth.dart';

class UserNameHeader extends StatefulWidget {
  const UserNameHeader({Key? key}) : super(key: key);

  @override
  State<UserNameHeader> createState() => _UserNameHeaderState();
}

class _UserNameHeaderState extends State<UserNameHeader> {
  Future<User>? _user;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _user = Provider.of<Auth>(context, listen: false).myProfile();
  }

  @override
  Widget build(BuildContext context) {
    Color greenLight = Color(0xff63d47a);

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
                  ? const SizedBox(
                      width: 50,
                    )
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
            FutureBuilder(
                future: _user,
                builder: (ctx, data) {
                  if (data.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  return Consumer<Auth>(
                      builder: (context, value, child) => Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    ' ${value.me.company.toUpperCase()} - ${value.me.city.toUpperCase()}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                GestureDetector(
                                  onTap: () {
                                    if (ModalRoute.of(context)?.settings.name ==
                                        UserDetails.routeName) {
                                      Navigator.of(context).pop();
                                    }
                                    Navigator.of(context).pushNamed(
                                        UserDetails.routeName,
                                        arguments: Provider.of<Auth>(context,
                                                listen: false)
                                            .userId);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 30),
                                    child: CircleAvatar(
                                      radius: 20,
                                      child: Text(value.me.company
                                          .substring(0, 1)
                                          .toUpperCase()),
                                      // backgroundImage: NetworkImage(logo),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                })
          ],
        ));
  }
}
