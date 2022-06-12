import 'package:flutter/material.dart';
import 'package:udhyog/widgets/press_table.dart';

class RadioType extends StatefulWidget {
  const RadioType({Key? key}) : super(key: key);

  @override
  State<RadioType> createState() => _RadioTypeState();
}

enum timeDuration { daily, weekly, monthly, customize }
enum reportType { report, chart }

class _RadioTypeState extends State<RadioType> {
  reportType? _reportType = reportType.report;
  timeDuration? _timeDuration = timeDuration.daily;
  bool _value = false;
  int val = -1;

  @override
  Widget build(BuildContext context) {
    return //Container(child:Text('Hello'));
        Container(
      child: Padding(
        padding: EdgeInsets.all(15),
        // width: 300,
        // height: 300,
        child: Column(
          children: [
            Container(
              height: 50,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Text("Time Duration: "),
                Container(
                  height: 50,
                  width: 110,
                  child: ListTile(
                    // title: Text(
                    //   "Report",
                    //   style: TextStyle(color: Colors.grey, fontSize: 15),
                    // ),
                    trailing: Text(
                      "Daily",
                      style: TextStyle(
                          color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                    ),
                    leading: Radio<timeDuration>(
                      value: timeDuration.daily,
                      groupValue: _timeDuration,
                      onChanged: (timeDuration? value) {
                        setState(() {
                          _timeDuration = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 110,
                  child: ListTile(
                    // title: Text(
                    //   "Chart",
                    //   style: TextStyle(color: Colors.grey, fontSize: 15),
                    // ),
                    trailing: Text(
                      "Weekly",
                      style: TextStyle(
                          color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                    ),
                    leading: Radio<timeDuration>(
                      value: timeDuration.weekly,
                      groupValue: _timeDuration,
                      onChanged: (timeDuration? value) {
                        setState(() {
                          _timeDuration = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 115,
                  child: ListTile(
                    // title: Text(
                    //   "Chart",
                    //   style: TextStyle(color: Colors.grey, fontSize: 15),
                    // ),
                    trailing: Text(
                      "Monthly",
                      style: TextStyle(
                          color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                    ),
                    leading: Radio<timeDuration>(
                      value: timeDuration.monthly,
                      groupValue: _timeDuration,
                      onChanged: (timeDuration? value) {
                        setState(() {
                          _timeDuration = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 130,
                  child: ListTile(
                    // title: Text(
                    //   "Chart",
                    //   style: TextStyle(color: Colors.grey, fontSize: 15),
                    // ),
                    trailing: Text(
                      "Customize",
                      style: TextStyle(
                          color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                    ),
                    leading: Radio<timeDuration>(
                      value: timeDuration.customize,
                      groupValue: _timeDuration,
                      onChanged: (timeDuration? value) {
                        setState(() {
                          _timeDuration = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                  ),
                ),
              ]),
            ),
            Row(children: [
              Text("Report Type: "),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  // title: Text(
                  //   "Report",
                  //   style: TextStyle(color: Colors.grey, fontSize: 15),
                  // ),
                  trailing: Text(
                    "Report",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<reportType>(
                    value: reportType.report,
                    groupValue: _reportType,
                    onChanged: (reportType? value) {
                      setState(() {
                        _reportType = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  title: Text(
                    "Chart",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  trailing: Text(
                    "Chart",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<reportType>(
                    value: reportType.chart,
                    groupValue: _reportType,
                    onChanged: (reportType? value) {
                      setState(() {
                        _reportType = value;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
