import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/menuItems.dart';
import 'package:udhyog/widgets/home_menu.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/slier.dart';

import '../providers/auth.dart';
import '../widgets/home_hero.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const routeName = '/main';
  @override
  Widget build(BuildContext context) {
    Color greenLight = Color(0xff63d47a);
    final deviceSize = MediaQuery.of(context).size;
    //final company = Provider.of<Auth>(context, listen: false).company;
    return SafeArea(
      child: Scaffold(
        body: Container(
            width: deviceSize.width,
            height: deviceSize.height,
            decoration: BoxDecoration(color: Colors.white),
            // height: MediaQuery.of(context).size.height -
            //     MediaQuery.of(context).padding.top,
            child: Column(children: [
              LogoHeading(),

              const SizedBox(
                height: 10,
              ),
              // Padding(
              //padding: const EdgeInsets.all(5.0),
              Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: greenLight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('hello',
                        //company
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    CircleAvatar(
                      child: Icon(Icons.person),
                    )
                  ],
                ),
              ),
              // ),
              const SizedBox(
                height: 10,
              ),
              HomeHero(),
              // HomePage(),
              const SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8),
                child: const Text(
                  'PROCESS MONITORING',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                //alignment: Alignment.center,
              ),
              Container(
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(5),
                // height: 6,
                width: 100,
                decoration: BoxDecoration(color: Colors.orange, boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.3),
                    spreadRadius: 1, //spread radius
                    blurRadius: 3, // blur radius
                    offset: const Offset(1, 5),
                  )
                ]),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.1),
                  itemBuilder: (ctx, index) => HomeMenu(
                      title: items[index].title,
                      img: items[index].img,
                      url: items[index].url),
                  itemCount: items.length,
                ),
              ),
            ])),
        //)
      ),
    );
  }
}
