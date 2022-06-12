import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/providers/press.dart';
import 'package:udhyog/screens/overview.dart';
import 'package:udhyog/screens/press_details.dart';
import 'package:udhyog/screens/report_download.dart';
import 'package:udhyog/widgets/addImage.dart';
import 'package:udhyog/widgets/newPress.dart';
import 'package:udhyog/widgets/pressListCards.dart';
import 'package:udhyog/widgets/pressList_tabs.dart';
import 'package:udhyog/widgets/press_list.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/userNameHeader.dart';

import '../models/press.dart';

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

  @override
  Widget build(BuildContext context) {
    Color backG = Color.fromARGB(174, 230, 231, 233);
    TabController _tabController = TabController(length: 6, vsync: this);
    final pressData = Provider.of<PressProvider>(context).presses;
    return SafeArea(
      child: Scaffold(
          body: Container(
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
                            return PressListCards(pressData[index].press_id,
                                pressData[index].press_name);
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
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(NewPress.routeName);
              })),
    );
  }
}
