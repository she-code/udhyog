import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:udhyog/providers/press.dart';
import 'package:udhyog/screens/newPress.dart';
import 'package:udhyog/widgets/overview.dart';
import 'package:udhyog/widgets/pressListCards.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/userNameHeader.dart';
import 'package:udhyog/screens/payment.dart';

class PressContainer extends StatefulWidget {
  const PressContainer({Key? key}) : super(key: key);
  static const routeName = '/PressContainer';
  @override
  _PressContainerState createState() => _PressContainerState();
}

class _PressContainerState extends State<PressContainer>
    with TickerProviderStateMixin {
  var _isinit = true;
  var _isLoading = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Provider.of<PressProvider>(context).getPressForCompany();
  // }

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<PressProvider>(context)
          .getPressForCompany()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isinit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future<void> _refreshPresses(BuildContext context) async {
    await Provider.of<PressProvider>(context, listen: false)
        .getPressForCompany();
  }

  @override
  Widget build(BuildContext context) {
    Color backG = Color.fromARGB(174, 230, 231, 233);
    TabController _tabController = TabController(length: 6, vsync: this);
    final pressData = Provider.of<PressProvider>(context).presses;
    return SafeArea(
        child: Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshPresses(context),
        child: Container(
            //padding: const EdgeInsets.all(8.0),
            color: backG,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              LogoHeading(),
              UserNameHeader(),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: pressData.length,
                        itemBuilder: (_, index) {
                          return PressListCards(
                              pressData[index].press_id,
                              pressData[index].press_name,
                              pressData[index].details);
                        }),
              ),
              Expanded(
                child: _isLoading
                    ? Center(
                        child: Text("No presses"),
                      )
                    : ListView.builder(
                        itemCount: pressData.length,
                        itemBuilder: (_, index) {
                          return Overview(
                              pressData[index].press_name,
                              pressData[index].press_id,
                              pressData[index].location,
                              pressData[index].frequnecy.toString(),
                              pressData[index].static_id,
                              pressData[index].TypeOfPress);
                        }),
              ),
            ])),
      ),
      floatingActionButton: SpeedDial(
          foregroundColor: Colors.white,
          // activeBackgroundColor: Colors.transparent,
          icon: Icons.menu,
          backgroundColor: Colors.amber,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.money),
                label: 'Make Payment',
                backgroundColor: Colors.amberAccent,
                foregroundColor: Colors.white,
                onTap: () {
                  //   Navigator.of(context)
                  //       .pushNamed(Payment.routeName, arguments: pressData.press_id);
                  // },
                }),
            SpeedDialChild(
              child: const Icon(Icons.add),
              label: 'Add Press',
              backgroundColor: Colors.amberAccent,
              foregroundColor: Colors.white,
              onTap: () {
                Navigator.of(context).pushNamed(NewPress.routeName);
              },
            ),
          ]),
    ));
  }
}
