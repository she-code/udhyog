import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/press.dart';
import '../providers/press.dart';
//import 'package';

class ReportTable extends StatelessWidget {
  var pressDetails;
  ReportTable(this.pressDetails);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                          DateFormat.E()
                              .format(DateTime.parse(
                                  pressDetails[index.key]['createdAt']))
                              .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          DateFormat.Hm()
                              .format(DateTime.parse(
                                  pressDetails[index.key]['createdAt']))
                              .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                    DataCell(Container(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          pressDetails[index.key]['BlockTemp'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  ],
                ))
          ]),
    );
  }
}
