import 'dart:io';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../providers/press.dart';
import '../screens/pdfPriview.dart';

class ReportTable extends StatefulWidget {
  var pressDetails;
  final String duration;
  final String pressName;
  ReportTable(this.pressDetails, this.duration, this.pressName);

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  @override
  Widget build(BuildContext context) {
    List<String> splitted = [];
    return widget.pressDetails != null
        ? Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(PdfPreviewPage.routeName,
                          arguments: [
                            widget.pressDetails,
                            widget.duration,
                            widget.pressName
                          ]);
                    },
                    child: const Text("Download")),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  headingRowColor: MaterialStateProperty.all(Colors.green),
                  columnSpacing: 40,
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  columns: const [
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
                    ...widget.pressDetails.asMap().entries.map((index) =>
                        DataRow(
                          cells: [
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  (() {
                                    if ((widget.pressDetails[index.key].date)
                                        .contains(" ")) {
                                      splitted =
                                          (widget.pressDetails[index.key].date)
                                              .split(' ');
                                      return splitted[0];
                                    }

                                    return (widget.pressDetails[index.key].date)
                                        .toString();
                                  })(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  (() {
                                    if (splitted.length == 3) {
                                      return ' ${splitted[1]} ${StringUtils.capitalize(splitted[2])}';
                                    }

                                    return '';
                                  })(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].TankTopTemp
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].TankLowerTemp
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].BlockTemp
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].HoseTemp
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].Timer
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget.pressDetails[index.key].PartCount
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                            DataCell(Container(
                                alignment: AlignmentDirectional.center,
                                child: Text(
                                  widget
                                      .pressDetails[index.key].powerConsumption
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                          ],
                        ))
                  ]),
            ),
          ])
        : const Text("No data");
  }
}
