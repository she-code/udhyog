import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'press_container.dart';
import '../widgets/logoHeading.dart';
import '../widgets/mainFooter.dart';
import '../widgets/userNameHeader.dart';
import '../providers/auth.dart';
import '../widgets/home_hero.dart';
import 'newPress.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // var _isinit = true;
  // var _isLoading = false;
  // @override
  // void didChangeDependencies() {
  //   if (_isinit) {
  //     setState(() {
  //       _isLoading = true;
  //     });

  //     Provider.of<Auth>(context).myProfile().then((data) => setState(() {
  //           _isLoading = false;
  //           print({data, data.company});
  //         }));
  //   }
  //   _isinit = false;
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    Color greenLight = Color(0xff63d47a);
    final deviceSize = MediaQuery.of(context).size;
    final company = Provider.of<Auth>(context, listen: false).company;
    final city = Provider.of<Auth>(context, listen: false).city;

    var children2 = [
      LogoHeading(),
      const SizedBox(
        height: 10,
      ),
      UserNameHeader(),
      const SizedBox(
        height: 10,
      ),
      GestureDetector(
        child: HomeHero(),
        onTap: () {
          Navigator.of(context).pushNamed(PressContainer.routeName);
        },
      ),
      MainFooter()
    ];
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            decoration: BoxDecoration(color: Colors.white),
            // height: MediaQuery.of(context).size.height -
            //     MediaQuery.of(context).padding.top,
            child: Column(children: children2)),

        floatingActionButton: FloatingActionButton(
            // backgroundColor: greenLight,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewPress.routeName);
            }),

        //)
      ),
    );
  }
}
