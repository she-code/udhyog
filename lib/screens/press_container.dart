import 'package:flutter/material.dart';
import 'package:udhyog/screens/overview.dart';
import 'package:udhyog/screens/press_details.dart';
import 'package:udhyog/screens/report_download.dart';
import 'package:udhyog/widgets/addImage.dart';
import 'package:udhyog/widgets/newPress.dart';
import 'package:udhyog/widgets/pressList_tabs.dart';
import 'package:udhyog/widgets/press_list.dart';

import '../models/press.dart';

class PressContainer extends StatefulWidget {
  const PressContainer({Key? key}) : super(key: key);
  static const routeName = '/PressContainer';
  @override
  _PressContainerState createState() => _PressContainerState();
}

class _PressContainerState extends State<PressContainer>
    with TickerProviderStateMixin {
  void _addNewPress(String pressType) {}
  // void _addNewPress(String pType, String presName) {
  //   final newTx = Press(
  //     pressId: 1,
  //     partCount: 1.2,
  //     pressName: presName,
  //     blockTemp: '23',
  //     clientId: 1,
  //     createdAt: DateTime.now(),
  //     hoseTemp: 24,
  //     pressType: pType,
  //     tankLowerTemp: 24,
  //     tankTopTemp: 25,
  //     timer: 123,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Color backG = Color.fromARGB(174, 230, 231, 233);
    TabController _tabController = TabController(length: 6, vsync: this);

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(8.0),
          color: backG,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/mainLogo.png',
                      // fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            'Turbo cast india (Private limited) Rajkot ',
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary)),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(color: Colors.green),
                        child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Text(
                                'Pattern Injection',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text('Pattern Processing',
                                  style: TextStyle(color: Colors.white))
                            ]),
                      )
                    ],
                  )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                child: TabBar(
                  labelStyle: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                  controller: _tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: true,
                  tabs: [
                    Tab(child: PressList('Overview')),
                    Tab(child: PressList('Location 1')),
                    Tab(child: PressList('Location 2')),
                    Tab(child: PressList('Location 3')),
                    Tab(child: PressList('Location 4')),
                    Tab(child: PressList('Location 5')),
                  ],
                ),
              ),
              //),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  child: TabBarView(controller: _tabController, children: [
                    Overview(),
                    PressDetails(),
                    ReportDownload(),
                    AddImage(),
                    Text('helle'),
                    Text('helle')
                  ]),
                ),
              )
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //     child: const Icon(Icons.add), onPressed: () {}
        //     // Navigator.of(context).pushNamed(AddPress.routeName)
        //     )
      ),
    );
  }
}
