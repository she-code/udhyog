import 'package:basic_utils/basic_utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';
import '../models/userPageListModel.dart';
import '../providers/auth.dart';
import '../providers/press.dart';

class UserPageExpandable extends StatefulWidget {
  const UserPageExpandable({Key? key}) : super(key: key);

  @override
  State<UserPageExpandable> createState() => _UserPageExpandableState();
}

Color iconColor = const Color(0xFF70CF7D);

class _UserPageExpandableState extends State<UserPageExpandable> {
  static Future<User>? _user;
  static var pressData;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _user = Provider.of<Auth>(context, listen: false).myProfile();

    Provider.of<PressProvider>(context, listen: false).getPressForCompany();
    // pressData = Provider.of<PressProvider>(context, listen: false).presses;
    // print(pressData.isEmpty);
    // print(pressData);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: itemData.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionPanelList(
            animationDuration: const Duration(milliseconds: 1000),
            dividerColor: Colors.red,
            elevation: 1,
            children: [
              ExpansionPanel(
                  body: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(child: itemData[index].discription)
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        itemData[index].headerItem,
                        style: TextStyle(
                          color: itemData[index].colorsItem,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                  isExpanded: itemData[index].expanded,
                  canTapOnHeader: true)
            ],
            expansionCallback: (int item, bool status) {
              setState(() {
                itemData[index].expanded = !itemData[index].expanded;
              });
            },
          );
        },
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem: 'Company Info',
      discription: FutureBuilder(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Text("error");
              } else {
                return Consumer<Auth>(
                    builder: (context, value, child) => Column(children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.email,
                                  size: 15,
                                  color: iconColor,
                                ),
                              ),
                              Text(
                                  utils.StringUtils.capitalize(value.me.email)),
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.phone,
                                    size: 15,
                                    color: iconColor,
                                  )),
                              Text((value.me.cellNo).toString())
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.person,
                                  size: 15,
                                  color: iconColor,
                                ),
                              ),
                              Text(utils.StringUtils.capitalize(
                                  value.me.contactPerson)),
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.home,
                                  size: 15,
                                  color: iconColor,
                                ),
                              ),
                              Text(
                                  '${utils.StringUtils.capitalize(value.me.address1)} ${utils.StringUtils.capitalize(value.me.city)},${utils.StringUtils.capitalize(value.me.state)},${utils.StringUtils.capitalize(value.me.country)}'),
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.pin,
                                  size: 15,
                                  color: iconColor,
                                ),
                              ),
                              Text((value.me.pin).toString()),
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(8),
                            child: Row(children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.payment,
                                  size: 15,
                                  color: iconColor,
                                ),
                              ),
                              Text(value.me.gstNo),
                            ]),
                            height: 50,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade400)),
                          )
                        ]));
              }
            }
          }),
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem: 'Presses',
      discription: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Active Presses"), Text("7")],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Inactive Presses"), Text("5")],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Total Presses"), Text("12")],
            ),
            const Divider(),
          ],
        ),
      ),
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem: 'Downloads',
      discription: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("PDF documents"), Text("7")],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Images"), Text("5")],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text("Total downloads"), Text("12")],
            ),
            const Divider(),
          ],
        ),
      ),
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem: 'Payment',
      discription: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Pending payments"), const Text("7")],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Text("Total Paid"), const Text("5")],
            ),
            const Divider(),
          ],
        ),
      ),
      colorsItem: Colors.green,
    ),
  ];
}
