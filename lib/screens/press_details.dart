import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/report_type.dart';
import 'package:udhyog/widgets/userNameHeader.dart';

import '../providers/press.dart';
import '../widgets/gauge.dart';
import '../widgets/press_table.dart';
import '../widgets/table.dart';

class PressDetails extends StatefulWidget {
  static final String routeName = '/pressdetails';
  const PressDetails({Key? key}) : super(key: key);

  @override
  State<PressDetails> createState() => _PressDetailsState();
}

enum reportType { report, chart }
enum timeDuration { daily, weekly, monthly, customize }

class _PressDetailsState extends State<PressDetails> {
  reportType? _reportType = reportType.report;
  timeDuration? _timeDuration = timeDuration.daily;

  @override
  Widget build(BuildContext context) {
    final pressData =
        Provider.of<PressProvider>(context, listen: false).presses;
    Color backG = Color.fromARGB(174, 230, 231, 233);

    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: backG,
          height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          //width: 400,
          child: SingleChildScrollView(
            child: Column(children: [
              LogoHeading(),
              const SizedBox(height: 10), UserNameHeader(),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: deviceSize.width,
                  //height: deviceSize.height,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Container(
                      width: 400,
                      height: 400,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          'assets/images/press_img.jpg',
                        ),
                        fit: BoxFit.cover,
                      )),
                      child: Text("Wait")
                      //  Image.asset("assets/images/mainLogo.png",
                      //     height: 40, width: 40)),
                      )),
              // Container(
              //     height: 400,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(15),
              //         image: DecorationImage(
              //           image: AssetImage(
              //             'assets/images/press_img.jpg',
              //           ),
              //           fit: BoxFit.cover,
              //         )),
              //     padding: EdgeInsets.all(15),
              //     child: Stack(
              //       children: [
              //         Positioned(
              //             top: 220,
              //             left: 25,
              //             child: Image.asset("assets/images/mainLogo.png",
              //                 height: 80, width: 70)),
              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 90,
              //           right: 80,
              //         ),
              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 90,
              //           right: 30,
              //         ),

              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 120,
              //           right: 80,
              //         ),

              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 120,
              //           right: 30,
              //         ),

              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 150,
              //           right: 80,
              //         ),

              //         Positioned(
              //           child: Text(
              //             '1',
              //             style: TextStyle(color: Colors.white, fontSize: 10),
              //           ),
              //           top: 150,
              //           right: 30,
              //         ),

              //         //Text('hi'))
              //       ],
              //     )),
              const SizedBox(
                height: 20,
              ),

              Container(
                  margin: EdgeInsets.all(8),
                  width: double.maxFinite,
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GaugeApp('Lower Tank Temp', 23),
                      GaugeApp('Higher Tank Temp', 25),
                      GaugeApp('Hose Temp', 10),
                      GaugeApp('Block Temp', 45),
                    ],
                  )),

              //RadioType(),
              // SizedBox(
              //   height: 20,
              // ),
              // ReportTable(),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(children: [
              //     Text("Report Type: "),
              //     Container(
              //       height: 50,
              //       width: 115,
              //       child: ListTile(
              //         // title: Text(
              //         //   "Report",
              //         //   style: TextStyle(color: Colors.grey, fontSize: 15),
              //         // ),
              //         trailing: Text(
              //           "Report",
              //           style: TextStyle(
              //               color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //         ),
              //         leading: Radio<reportType>(
              //           value: reportType.report,
              //           groupValue: _reportType,
              //           onChanged: (reportType? value) {
              //             setState(() {
              //               _reportType = value;
              //             });
              //           },
              //           activeColor: Colors.green,
              //         ),
              //       ),
              //     ),
              //     Container(
              //       height: 50,
              //       width: 110,
              //       child: ListTile(
              //         title: Text(
              //           "Chart",
              //           style: TextStyle(color: Colors.grey, fontSize: 15),
              //         ),
              //         trailing: Text(
              //           "Chart",
              //           style: TextStyle(
              //               color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //         ),
              //         leading: Radio<reportType>(
              //           value: reportType.chart,
              //           groupValue: _reportType,
              //           onChanged: (reportType? value) {
              //             setState(() {
              //               _reportType = value;
              //             });
              //           },
              //           activeColor: Colors.green,
              //         ),
              //       ),
              //     ),
              //   ]),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 50,
              //     child: ListView(scrollDirection: Axis.horizontal, children: [
              //       Text("Time Duration: "),
              //       Container(
              //         height: 50,
              //         width: 110,
              //         child: ListTile(
              //           // title: Text(
              //           //   "Report",
              //           //   style: TextStyle(color: Colors.grey, fontSize: 15),
              //           // ),
              //           trailing: Text(
              //             "Daily",
              //             style: TextStyle(
              //                 color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //           ),
              //           leading: Radio<timeDuration>(
              //             value: timeDuration.daily,
              //             groupValue: _timeDuration,
              //             onChanged: (timeDuration? value) {
              //               setState(() {
              //                 _timeDuration = value;
              //               });
              //             },
              //             activeColor: Colors.green,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         width: 120,
              //         child: ListTile(
              //           // title: Text(
              //           //   "Chart",
              //           //   style: TextStyle(color: Colors.grey, fontSize: 15),
              //           // ),
              //           trailing: Text(
              //             "Weekly",
              //             style: TextStyle(
              //                 color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //           ),
              //           leading: Radio<timeDuration>(
              //             value: timeDuration.weekly,
              //             groupValue: _timeDuration,
              //             onChanged: (timeDuration? value) {
              //               setState(() {
              //                 _timeDuration = value;
              //               });
              //             },
              //             activeColor: Colors.green,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         width: 125,
              //         child: ListTile(
              //           // title: Text(
              //           //   "Chart",
              //           //   style: TextStyle(color: Colors.grey, fontSize: 15),
              //           // ),
              //           trailing: Text(
              //             "Monthly",
              //             style: TextStyle(
              //                 color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //           ),
              //           leading: Radio<timeDuration>(
              //             value: timeDuration.monthly,
              //             groupValue: _timeDuration,
              //             onChanged: (timeDuration? value) {
              //               setState(() {
              //                 _timeDuration = value;
              //               });
              //             },
              //             activeColor: Colors.green,
              //           ),
              //         ),
              //       ),
              //       Container(
              //         height: 50,
              //         width: 135,
              //         child: ListTile(
              //           // title: Text(
              //           //   "Chart",
              //           //   style: TextStyle(color: Colors.grey, fontSize: 15),
              //           // ),
              //           trailing: Text(
              //             "Customize",
              //             style: TextStyle(
              //                 color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              //           ),
              //           leading: Radio<timeDuration>(
              //             value: timeDuration.customize,
              //             groupValue: _timeDuration,
              //             onChanged: (timeDuration? value) {
              //               setState(() {
              //                 _timeDuration = value;
              //               });
              //             },
              //             activeColor: Colors.green,
              //           ),
              //         ),
              //       ),
              //     ]),
              //   ),
              // ),
              // if (_reportType == reportType.report) ReportTable(),
              // if (_reportType == reportType.chart) Text('chart'),
            ]),
          ),
        ),
      ),
    );
  }
}
