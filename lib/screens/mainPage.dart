import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/menuItems.dart';
import 'package:udhyog/screens/press_container.dart';
import 'package:udhyog/screens/press_details.dart';
import 'package:udhyog/widgets/home_menu.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/mainFooter.dart';
import 'package:udhyog/widgets/slier.dart';
import 'package:udhyog/widgets/userNameHeader.dart';

import '../providers/auth.dart';
import '../widgets/home_hero.dart';
import '../widgets/newPress.dart';

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
            backgroundColor: greenLight,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NewPress.routeName);
            }),

        //)
      ),
    );
  }
}
   // HomePage(),
                // const SizedBox(height: 20),
                // Container(
                //   margin: EdgeInsets.all(8),
                //   child: const Text(
                //     'PROCESS MONITORING',
                //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                //   ),
                //   //alignment: Alignment.center,
                // ),
                // Container(
                //   padding: EdgeInsets.all(2),
                //   margin: EdgeInsets.all(5),
                //   // height: 6,
                //   width: 100,
                //   decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                //     BoxShadow(
                //       color: Colors.black26.withOpacity(0.3),
                //       spreadRadius: 1, //spread radius
                //       blurRadius: 3, // blur radius
                //       offset: const Offset(1, 5),
                //     )
                //   ]),
                // ),
                // const SizedBox(height: 20),
                // Expanded(
                //   child: GridView.builder(
                //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //         crossAxisCount: 3,
                //         crossAxisSpacing: 8,
                //         mainAxisSpacing: 8,
                //         childAspectRatio: 1.1),
                //     itemBuilder: (ctx, index) => HomeMenu(
                //         title: items[index].title,
                //         img: items[index].img,
                //         url: items[index].url),
                //     itemCount: items.length,
                //   ),
                // ),
