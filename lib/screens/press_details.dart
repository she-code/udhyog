import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import 'package:udhyog/providers/auth.dart';
import 'package:udhyog/screens/payment.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import 'package:udhyog/widgets/show_chart.dart';
import 'package:udhyog/widgets/userNameHeader.dart';

import '../providers/press.dart';
import '../widgets/gauge.dart';
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
  @override
  void didChangeDependencies() {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;

    if (_isinit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<PressProvider>(context, listen: false)
          .getDailyPressData(pressId)
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }
    _isinit = false;
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
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
      });
    });
  }

  Widget Report_Type() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Text("Report Type: "),
        Container(
          width: 110,
          child: ListTile(
            // title: Text(
            //   "Report",
            //   style: TextStyle(color: Colors.grey, fontSize: 15),
            // ),
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
        Container(
          width: 110,
          child: ListTile(
            // title: Text(
            //   "Chart",
            //   style: TextStyle(color: Colors.grey, fontSize: 15),
            //),
            trailing: Text(
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
      child: Container(
        width: double.infinity,
        child: Wrap(children: [
          Container(
            child: Text("Time Duration: "),
            margin: EdgeInsets.only(top: 15),
          ),
          Container(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: Text(
                "All",
                style: TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
              ),
              leading: Radio<timeDuration>(
                value: timeDuration.all,
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
                    Provider.of<PressProvider>(context, listen: false)
                        .getDailyPressData(pressId);
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          Container(
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
                    Provider.of<PressProvider>(context, listen: false)
                        .getWeeklyPressData(pressId);
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          Container(
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
                    Provider.of<PressProvider>(context, listen: false)
                        .getMonthlyPressData(pressId);
                  });
                },
                activeColor: Colors.green,
              ),
            ),
          ),
          Container(
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
                  _presentDatePicker();
                  Provider.of<PressProvider>(context, listen: false)
                      .getCustomizedPressData(
                          pressId, _selectedDate.toString());
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
      child: Container(
        width: 500,
        height: 500,
        child: Column(children: [
          Container(
            child: Text("Select Temperature: "),
            margin: EdgeInsets.only(top: 15),
          ),
          Container(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: Text(
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
          Container(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Report",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: Text(
                "Temperature High",
                style: TextStyle(
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
          Container(
            width: 110,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: Text(
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
          Container(
            width: 115,
            child: ListTile(
              // title: Text(
              //   "Chart",
              //   style: TextStyle(color: Colors.grey, fontSize: 15),
              // ),
              trailing: Text(
                "Block Temp",
                style: TextStyle(
                    color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
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
    final pressId = ModalRoute.of(context)?.settings.arguments as String;
    final pressData =
        Provider.of<PressProvider>(context, listen: false).findByID(pressId);
    final pressDetails = pressData.details.isEmpty ? [] : pressData.details;
    final latestDetail = pressData.details.isEmpty ? [] : pressDetails.last;
    final pressDataList =
        Provider.of<PressProvider>(context, listen: false).pressdatas;
    final lastPressData = pressDataList.isEmpty ? [] : pressDataList.last;

    // print(lastPressData.entery_id);
    //pressDataList.map((index) => {print(pressDataList[index]['BlockTemp'])});
    // print(pressDetails.last);
    final logo = Provider.of<Auth>(context, listen: false).logo;
    Color backG = Color.fromARGB(174, 230, 231, 233);
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: pressDetails.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                color: backG,
                height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                //width: 400,
                child: SingleChildScrollView(
                    child: Column(children: [
                  LogoHeading(),
                  const SizedBox(height: 10),
                  UserNameHeader(),
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
                                    padding: EdgeInsets.all(4),
                                    color: Colors.white,
                                    child: Text(
                                      StringUtils.capitalize(
                                          pressData.press_name),
                                      style: TextStyle(fontSize: 14),
                                    ))),
                            Positioned(
                              top: 107,
                              right: 63,
                              child: Text(
                                latestDetail['BlockTemp'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 107,
                              right: 105,
                              child: Text(
                                latestDetail['TankTopTemp'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 133,
                              right: 63,
                              child: Text(
                                latestDetail['TankLowerTemp'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 133,
                              right: 105,
                              child: Text(
                                latestDetail['HoseTemp']!.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 165,
                              right: 63,
                              child: Text(
                                latestDetail['PartCount']!.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Positioned(
                              top: 165,
                              right: 105,
                              child: Text(
                                latestDetail['Timer']!.toString(),
                                style: TextStyle(color: Colors.white),
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
                  SizedBox(
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
                      : SizedBox(),
                  if (_reportType == reportType.report)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReportTable(pressDataList),
                    ),
                  if (_reportType == reportType.chart)
                    ShowChart(pressId, pressDataList),
                  //  Text('chart'),
                ])),
              ),
            ),
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
