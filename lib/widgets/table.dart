import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/press.dart';
import '../providers/press.dart';
//import 'package';

class ReportTable extends StatelessWidget {
  // final List<Press> press = PressProvider('', [
  //   Press(
  //     pressId: 1,
  //     partCount: 1.2,
  //     pressName: 'Press 1',
  //     blockTemp: '23',
  //     clientId: 1,
  //     createdAt: DateTime.now(),
  //     hoseTemp: 24,
  //     pressType: 'automatic',
  //     tankLowerTemp: 24,
  //     tankTopTemp: 25,
  //     timer: 123,
  //   ),
  //   Press(
  //     pressId: 2,
  //     partCount: 1.2,
  //     pressName: 'Press 2',
  //     blockTemp: '23',
  //     clientId: 1,
  //     createdAt: DateTime.now(),
  //     hoseTemp: 24,
  //     pressType: 'automatic',
  //     tankLowerTemp: 24,
  //     tankTopTemp: 25,
  //     timer: 123,
  //   ),
  //   Press(
  //     pressId: 3,
  //     partCount: 1.2,
  //     pressName: 'Press 3',
  //     blockTemp: '23',
  //     clientId: 1,
  //     createdAt: DateTime.now(),
  //     hoseTemp: 24,
  //     pressType: 'automatic',
  //     tankLowerTemp: 24,
  //     tankTopTemp: 25,
  //     timer: 123,
  //   ),
  // ]).presses;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
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
              // ...press.map((press) => DataRow(
              //       cells: [
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(
              //               DateFormat.yMd().format(DateTime.now()).toString(),
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(
              //               DateFormat.Hm().format(DateTime.now()).toString(),
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(
              //               press.tankTopTemp.toString(),
              //               style: TextStyle(fontWeight: FontWeight.bold),
              //             ))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(press.tankLowerTemp.toString()))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(press.blockTemp.toString()))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(press.hoseTemp.toString()))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(press.timer.toString()))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text(press.partCount.toString()))),
              //         DataCell(Container(
              //             alignment: AlignmentDirectional.center,
              //             child: Text('y'))),
              //       ],
              //     ))
            ]),
      ),
    );
  }
}
// class Press_Table extends StatelessWidget {
//   const Press_Table({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       child: ListView(
//         // scrollDirection: Axis.horizontal,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8),
//             child: Table(
//               border: TableBorder.all(color: Colors.black38, width: 2),
//               // columnWidths: {0: FixedColumnWidth(1)},
//               children: [
//                 TableRow(children: [
//                   TableCell(
//                     child: Text('Lower tank Temp',
//                         style: TextStyle(fontSize: 15.0)),
//                   ),
//                   Text('High tank Temp', style: TextStyle(fontSize: 15.0)),
//                   Text('Hose Temp', style: TextStyle(fontSize: 15.0)),
//                   Text('Block Temp', style: TextStyle(fontSize: 15.0)),
//                   Text('Part Count', style: TextStyle(fontSize: 15.0)),
//                   Text('Timer', style: TextStyle(fontSize: 15.0))
//                 ])
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
