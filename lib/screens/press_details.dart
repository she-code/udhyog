import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/providers/auth.dart';
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

  void updateReportType(reportType rt) {
    setState(() {
      _reportType = rt;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final pressId = ModalRoute.of(context)?.settings.arguments as String;
    final pressData =
        Provider.of<PressProvider>(context, listen: false).findByID(pressId);
    final pressDetails = pressData.details.isEmpty ? [] : pressData.details;
    final latestDetail = pressData.details.isEmpty ? [] : pressDetails.last;
    //pressDetails.map((index) => {print(pressDetails[index]['BlockTemp'])});
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
                    Container(
                        margin: EdgeInsets.all(8),
                        width: double.maxFinite,
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GaugeApp('Lower Tank Temp',
                                latestDetail["TankLowerTemp"]),
                            GaugeApp('Higher Tank Temp',
                                latestDetail['TankTopTemp']),
                            GaugeApp('Hose Temp', latestDetail['HoseTemp']),
                            GaugeApp('Block Temp',
                                double.parse(latestDetail['BlockTemp'])),
                          ],
                        )),
                    //  RadioType(reportType, updateReportType),
                    SizedBox(
                      height: 20,
                    ),
                    Report_Type(),
                    _time_Duration(),
                    if (_reportType == reportType.report)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ReportTable(pressDetails),
                      ),
                    if (_reportType == reportType.chart) Text('chart'),
                  ]),
                ),
              ),
            ),
    );
  }
}
