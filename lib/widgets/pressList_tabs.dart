import 'package:flutter/material.dart';
import 'package:udhyog/widgets/press_list.dart';

class PressListTabs extends StatefulWidget {
  const PressListTabs({Key? key}) : super(key: key);

  @override
  State<PressListTabs> createState() => _PressListTabsState();
}

class _PressListTabsState extends State<PressListTabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Creates border
                    color: Colors.greenAccent),
                tabs: [
                  Press_List('Overview'),
                  Press_List('Press 1'),
                  Press_List('Press 2'),
                  Press_List('Press 3'),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Text("Overview"),
            Text("Press 1"),
            Text("press 2"),
            Text("press 3"),
          ],
        ),
      ),
    );
  }
}
