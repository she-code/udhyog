import 'dart:ui';

import 'package:flutter/material.dart';

import 'press_container.dart';
import '../widgets/logoHeading.dart';
import '../widgets/mainFooter.dart';
import '../widgets/userNameHeader.dart';
import '../widgets/home_hero.dart';
import 'newPress.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    Color greenLight = const Color(0xff63d47a);
    final deviceSize = MediaQuery.of(context).size;
    // final company = Provider.of<Auth>(context, listen: false).company;
    // final city = Provider.of<Auth>(context, listen: false).city;

    var children2 = [
      const LogoHeading(),
      const SizedBox(
        height: 10,
      ),
      const UserNameHeader(),
      const SizedBox(
        height: 10,
      ),
      GestureDetector(
        child: const HomeHero(),
        onTap: () {
          Navigator.of(context).pushNamed(PressContainer.routeName);
        },
      ),
      // TextButton(
      //     onPressed: () {
      //       Provider.of<Auth>(context, listen: false).logout();

      //       Navigator.of(context).pushReplacementNamed('/');
      //     },
      //     child: Text('logout')),
      const MainFooter()
    ];
    int _selectedIndex = 1;
    return SafeArea(
        child: Scaffold(
      body: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          decoration: const BoxDecoration(color: Colors.white),
          // height: MediaQuery.of(context).size.height -
          //     MediaQuery.of(context).padding.top,
          child: Column(
            children: children2,
          )),
      floatingActionButton: FloatingActionButton(
          // backgroundColor: greenLight,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(NewPress.routeName);
          }),
    ));
  }
}
