import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import '../models/press.dart';
import '../providers/press.dart';
//import 'package';
import 'package:printing/printing.dart';

import '../screens/pdfPriview.dart';

class ReportTable extends StatelessWidget {
  var pressDetails;
  ReportTable(this.pressDetails);
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/report.pdf');
  }

  Future<Uint8List> _createPdf() async {
    print("clicked");
    try {
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
                            .format(DateTime.parse(
                                pressDetails[index.key].createdAt))
                            .toString(),
                        DateFormat.MEd()
                            .format(DateTime.parse(
                                pressDetails[index.key].createdAt))
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
      //final directory = await getApplgetApplicationDocumentsDirectory();
      final file = await _localFile;
      final dow = await file.writeAsBytes(await pdf.save());
      return pdf.save();
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(PdfPreviewPage.routeName,
                    arguments: pressDetails);
              },
              child: Text("Download")),
        ],
      ),
      SizedBox(
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
