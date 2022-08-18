//import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/auth.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/userNameHeader.dart';
import 'package:udhyog/widgets/userPageExpandeble.dart';

import '../providers/auth.dart';

class UserDetails extends StatefulWidget {
  static String routeName = '/userInfo';

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  late Future<User> _user;
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _user = Provider.of<Auth>(context, listen: false).myProfile();
    // me = Provider.of<Auth>(context, listen: false).me != null
    //     ? Provider.of<Auth>(context, listen: false).me
    //     : '';
    // print(me);
    // print({me.email});
  }

  @override
  Widget build(BuildContext context) {
    // final company = Provider.of<Auth>(context, listen: false).company;
    // final city = Provider.of<Auth>(context, listen: false).company;
    // late List<bool> _isOpen;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            LogoHeading(),
            UserNameHeader(),
            Expanded(child: UserPageExpandable()),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: const Text('LOGOUT')),
          ],
        ),
      ),
    ));
  }
}
