import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/widgets/chart.dart';
import '../models/press.dart';

import '../models/pressAvg.dart';
import '../providers/auth.dart';
import '../screens/payment.dart';
import '../widgets/logoHeading.dart';
import '../widgets/userNameHeader.dart';
import '../providers/press.dart';
import '../widgets/table.dart';
import 'newPress.dart';

class PressDetails extends StatefulWidget {
  static String routeName = '/pressdetails';
  const PressDetails({Key? key}) : super(key: key);

  @override
  State<PressDetails> createState() => _PressDetailsState();
}

enum reportType { report, chart }

enum timeDuration { daily, weekly, monthly, customize, all }

enum choose_temp { lowTemp, highTemp, hoseTemp, blockTemp }

class _PressDetailsState extends State<PressDetails> {
  reportType? _reportType = reportType.report;
  timeDuration? _timeDuration = timeDuration.all;
  choose_temp? _tempChoice = choose_temp.lowTemp;
  DateTime _selectedDate = DateTime.now();

  void updateReportType(reportType rt) {
    setState(() {
      _reportType = rt;
    });
  }

  var _isinit = true;
  var _isLoading = false;
  var showTime = true;
  String duration = 'daily';
  String? pressId;
  GlobalKey _chartGlobal = GlobalKey();
  // RenderRepaintBoundary boundary = _chartGlobal.currentContext.findRenderObject();
  Future<List<PressAverage>>? _presess;
  @override
  void didChangeDependencies() {
    pressId = ModalRoute.of(context)?.settings.arguments as String;

    if (_isinit) {
      setState(() {
        _isLoading = true;
      });

      _presess = Provider.of<PressProvider>(context, listen: false)
          .getDailyTempLowPressData(pressId!);

      _isinit = false;
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }
  }

  void _presentDatePicker() {
    final today = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: today.subtract(const Duration(days: 30)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        // print(_selectedDate);
      });
    });
  }

  Widget Report_Type() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        const Text("Report Type: "),
        SizedBox(
          width: 110,
          child: ListTile(
            trailing: const Text(
              "Report",
              style:
                  TextStyle(color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
            ),
            leading: Radio<reportType>(
              value: reportType.report,
              groupValue: _reportType,
              onChanged: (reportType? value) {
                setState(() {
                  _reportType = value;
                  showTime = true;
                });
              },
              activeColor: Colors.green,
            ),
          ),
        ),
        SizedBox(
          width: 110,
          child: ListTile(
            trailing: const Text(
              "Chart",
              style:
                  TextStyle(color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
            ),
            leading: Radio<reportType>(
              value: reportType.chart,
              groupValue: _reportType,
              onChanged: (reportType? value) {
                setState(() {
                  _reportType = value;
                  showTime = false;
                });
              },
              activeColor: Colors.green,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _time_Duration() {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(children: [
          Container(
            child: const Text("Time Duration: "),
            margin: const EdgeInsets.only(top: 15),
          ),
          // Container(
          //   width: 110,
          //   child: ListTile(
          //     // title: Text(
          //     //   "Report",
          //     //   style: TextStyle(color: Colors.grey, fontSize: 15),
          //     // ),
          //     trailing: Text(
          //       "All",
          //       style: TextStyle(
          //           color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
          //     ),
          //     leading: Radio<timeDuration>(
          //       value: timeDuration.all,
          //       groupValue: _timeDuration,
          //       onChanged: (timeDuration? value) {
          //         setState(() {
          //           _timeDuration = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
                "Daily",
                style: const TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<timeDuration>(
                value: timeDuration.daily,
                groupValue: _timeDuration,
                onChanged: (timeDuration? value) {
                  setState(() {
                    _timeDuration = value;
                    _presess =
                        Provider.of<PressProvider>(context, listen: false)
                            .getDailyTempLowPressData(pressId);
                    duration = 'daily';
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
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
                    _presess =
                        Provider.of<PressProvider>(context, listen: false)
                            .getWeeklyPressData(pressId);
                    duration = 'weekly';
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 115,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
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
                    _presess =
                        Provider.of<PressProvider>(context, listen: false)
                            .getMonthlyPressData(pressId);
                    duration = 'monthly';
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 130,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
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
                  _presentDatePicker();
                  _presess = Provider.of<PressProvider>(context, listen: false)
                      .getCustomizedPressData(
                          pressId, _selectedDate.toString());
                  duration = _selectedDate.toString();
                },
                activeColor: Colors.green,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget selectTemp() {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 500,
        height: 500,
        child: Column(children: [
          Container(
            child: const Text("Select Temperature: "),
            margin: const EdgeInsets.only(top: 15),
          ),
          SizedBox(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
                "Temperature Low",
                style: TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<choose_temp>(
                value: choose_temp.lowTemp,
                groupValue: _tempChoice,
                onChanged: (choose_temp? value) {
                  setState(() {
                    _tempChoice = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
                "Temperature High",
                style: const TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<choose_temp>(
                value: choose_temp.highTemp,
                groupValue: _tempChoice,
                onChanged: (choose_temp? value) {
                  setState(() {
                    _tempChoice = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
                "Hose Temp",
                style: TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<choose_temp>(
                value: choose_temp.hoseTemp,
                groupValue: _tempChoice,
                onChanged: (choose_temp? value) {
                  setState(() {
                    _tempChoice = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          SizedBox(
            width: 115,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: const Text(
                "Block Temp",
                style: const TextStyle(
                    color: const Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<choose_temp>(
                value: choose_temp.blockTemp,
                groupValue: _tempChoice,
                onChanged: (choose_temp? value) {
                  setState(() {
                    _tempChoice = value;
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pressData =
        Provider.of<PressProvider>(context, listen: false).findByID(pressId!);
    final pressDetails = pressData.details.isEmpty ? [] : pressData.details;
    final latestDetail = pressData.details.isEmpty ? [] : pressDetails.last;

    // print(lastPressData.entery_id);
    //pressDataList.map((index) => {print(pressDataList[index]['BlockTemp'])});
    // print(pressDetails.last);
    final logo = Provider.of<Auth>(context, listen: false).logo;
    Color backG = const Color.fromARGB(174, 230, 231, 233);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: pressDetails.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(children: [
              const LogoHeading(),
              const SizedBox(height: 10),
              const UserNameHeader(),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: deviceSize.width,
                  //height: deviceSize.height,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        'assets/images/press_img.jpg',
                      ),
                      fit: BoxFit.cover,
                    )),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 100,
                          left: 60,
                          child: Image.asset("assets/images/mainLogo.png",
                              height: 50, width: 60),
                        ),
                        Positioned(
                            bottom: 110,
                            left: 153,
                            child: Container(
                                alignment: Alignment.center,
                                width: 70,
                                padding: const EdgeInsets.all(4),
                                color: Colors.white,
                                child: Text(
                                  StringUtils.capitalize(pressData.press_name),
                                  style: const TextStyle(fontSize: 14),
                                ))),
                        Positioned(
                          top: 107,
                          right: 63,
                          child: Text(
                            latestDetail['BlockTemp'].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 107,
                          right: 105,
                          child: Text(
                            latestDetail['TankTopTemp'].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 133,
                          right: 63,
                          child: Text(
                            latestDetail['TankLowerTemp'].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 133,
                          right: 105,
                          child: Text(
                            latestDetail['HoseTemp']!.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          right: 63,
                          child: Text(
                            latestDetail['PartCount']!.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          top: 165,
                          right: 105,
                          child: Text(
                            latestDetail['Timer']!.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 100,
                        //   right: 60,
                        //   child: Image.network('http://localhost/:5001/$logo',
                        //       height: 50, width: 60),
                        // )
                      ],
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //     margin: EdgeInsets.all(8),
              //     width: double.maxFinite,
              //     height: 200,
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       children: [
              //         GaugeApp(
              //             'Lower Tank Temp', latestDetail["TankLowerTemp"]),
              //         GaugeApp(
              //             'Higher Tank Temp', latestDetail['TankTopTemp']),
              //         GaugeApp('Hose Temp', latestDetail['HoseTemp']),
              //         GaugeApp('Block Temp',
              //             double.parse(latestDetail['BlockTemp'])),
              //       ],
              //     )),
              //  RadioType(reportType, updateReportType),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Report_Type(),
              ),
              showTime
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: _time_Duration(),
                    )
                  : const SizedBox(),
              if (_reportType == reportType.report)
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder(
                        future: _presess,
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("No data");
                          }
                          return ReportTable(
                              snapshot.data, duration, pressData.press_name);
                        }))),

              if (_reportType == reportType.chart)
                Chart(
                    // key: _chartGlobal,
                    )
              //  Text('chart'),
            ])),
      floatingActionButton:
          SpeedDial(icon: Icons.menu, backgroundColor: Colors.amber, children: [
        SpeedDialChild(
          child: const Icon(Icons.money),
          label: 'Make Payment',
          foregroundColor: Colors.white,
          backgroundColor: Colors.amberAccent,
          onTap: () {
            Navigator.of(context)
                .pushNamed(Payment.routeName, arguments: pressData.press_id);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Press',
          foregroundColor: Colors.white,
          backgroundColor: Colors.amberAccent,
          onTap: () {
            Navigator.of(context).pushNamed(NewPress.routeName);
          },
        ),
      ]),
    );
  }
}
