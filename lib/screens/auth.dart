import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/providers/auth.dart';

import 'loginUp.dart';
import 'register.dart';
import '../widgets/logoHeading.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  var isLogin = true;
  void changeStatus() {
    setState(() {
      isLogin = !isLogin;
    });
    print(isLogin);
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    Color backG = const Color(0xFFE6E7E9);
    final token = Provider.of<Auth>(context, listen: false).token ?? '';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: backG,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const LogoHeading(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Container(
                    //padding: const EdgeInsets.all(15),
                    child: const Text(
                      'Udhyog 4.0 (U4) is a start-up initiation by professionals in 2019, and mainly provides technological solutions related to emerging technologies such as Industry 4.0. This in turn transform existing industrial setup into SMART and sustainable manufacturing setup. ',
                      maxLines: 7,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        overflow: TextOverflow.visible,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLogin
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: LoginUP(changeStatus),
                      ))
                    : Expanded(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Register(),
                      ))
                // Container(
                //   width: double.maxFinite,
                //   child: TabBar(
                //     labelStyle: const TextStyle(
                //         fontSize: 18.0, fontWeight: FontWeight.w600),
                //     controller: _tabController,
                //     labelPadding: EdgeInsets.zero,
                //     isScrollable: true,
                //     tabs: [
                //       Container(
                //         margin: const EdgeInsets.only(left: 15, right: 20),
                //         padding: const EdgeInsets.all(6),
                //         child: const Text(
                //           'SIGN IN',
                //           style: TextStyle(
                //               color: Colors.orange,
                //               fontSize: 18,
                //               fontWeight: FontWeight.normal),
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.only(left: 15, right: 20),
                //         padding: const EdgeInsets.all(6),
                //         child: const Text(
                //           'SIGN UP',
                //           style: TextStyle(
                //               color: Colors.orange,
                //               fontSize: 18,
                //               fontWeight: FontWeight.normal),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Container(
                //     margin: const EdgeInsets.all(10),
                //     width: double.maxFinite,
                //     child: TabBarView(
                //         controller: _tabController,
                //         children: [LoginUP(), Register()]),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
