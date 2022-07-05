import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

import '../models/press.dart';
import '../providers/press.dart';
//import 'package';

class ReportTable extends StatelessWidget {
  var pressDetails;
  ReportTable(this.pressDetails);
  void _createPdf() async {
    print("clicked");
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(context: context, data: <List<String>>[
            <String>[
              'Date',
              'Time',
              'Temprature-Tank Top(C)',
              'Temprature-Tank Lower(C)',
              'Temprature-Block (C)',
              'Dwell Time',
              'Part Counter',
              'Power Consumption'
            ],
            ...pressDetails
                .asMap()
                .entries
                .map((index) => [
                      DateFormat.MEd()
                          .format(
                              DateTime.parse(pressDetails[index.key].createdAt))
                          .toString(),
                      DateFormat.MEd()
                          .format(
                              DateTime.parse(pressDetails[index.key].createdAt))
                          .toString(),
                      pressDetails[index.key].TankTopTemp.toString(),
                      pressDetails[index.key].TankLowerTemp.toString(),
                      pressDetails[index.key].BlockTemp.toString(),
                      pressDetails[index.key].HoseTemp.toString(),
                      pressDetails[index.key].Timer.toString(),
                      pressDetails[index.key].PartCount.toString(),
                      pressDetails[index.key].powerConsumption.toString()
                    ])
                .toList()
          ]),
        ],
      ),
    );
    final file = File('example.pdf');
    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    // final weekData = pressDetails.where((press) {
    //   var currentDate = DateTime.tryParse(press["createdAt"]);
    //   var now_1w = DateTime.now().subtract(Duration(days: 7));
    //   // currentDate.is
    //   return currentDate!.isBefore(now_1w);
    // }).toList();
    // final dailyData = pressDetails.reversed.where((press) {
    //   var currentDate = DateTime.tryParse(press["createdAt"]);
    //   var now_1w = DateTime.now().subtract(Duration(days: 7));

    //   //print(now_1w.day);
    //   return currentDate!.isBefore(now_1w);
    // }).toList();
    return Column(children: [
      ElevatedButton(onPressed: _createPdf, child: Text("Download")),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.green),
            columnSpacing: 40,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Time')),
              DataColumn(label: Text('Temprature-Tank Top(C)')),
              DataColumn(label: Text('Temprature-Tank Lower(C)')),
              DataColumn(label: Text('Temprature-Block (C)')),
              DataColumn(label: Text('Temprature-Home (C)')),
              DataColumn(label: Text('Dwell Time')),
              DataColumn(label: Text('Part Counter')),
              DataColumn(label: Text('Power Consumption')),
            ],
            rows: [
              ...pressDetails.asMap().entries.map((index) => DataRow(
                    cells: [
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            DateFormat.MEd()
                                .format(DateTime.parse(
                                    pressDetails[index.key].createdAt))
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            DateFormat.Hm()
                                .format(DateTime.parse(
                                    pressDetails[index.key].createdAt))
                                .toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].TankTopTemp.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].TankLowerTemp.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].BlockTemp.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].HoseTemp.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].Timer.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].PartCount.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                      DataCell(Container(
                          alignment: AlignmentDirectional.center,
                          child: Text(
                            pressDetails[index.key].powerConsumption.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                    ],
                  ))
            ]),
      ),
    ]);
  }
}
