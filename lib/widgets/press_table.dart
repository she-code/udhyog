import 'package:flutter/material.dart';

class PressTable extends StatefulWidget {
  const PressTable({Key? key}) : super(key: key);

  @override
  State<PressTable> createState() => _PressTableState();
}

class _PressTableState extends State<PressTable> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(20),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 2),
          children: [
            TableRow(children: [
              Column(children: [
                Text('Lower tank Temp', style: TextStyle(fontSize: 15.0))
              ]),
              Column(children: [
                Text('High tank Temp', style: TextStyle(fontSize: 15.0))
              ]),
              Column(children: [
                Text('Hose Temp', style: TextStyle(fontSize: 15.0))
              ]),
              Column(children: [
                Text('Block Temp', style: TextStyle(fontSize: 15.0))
              ]),
              // Column(children: [
              //   Text('Part Count', style: TextStyle(fontSize: 15.0))
              // ]),
              // Column(
              //     children: [Text('Timer', style: TextStyle(fontSize: 15.0))]),
            ]),
            TableRow(children: [
              Column(children: [Text('Javatpoint')]),
              Column(children: [Text('Flutter')]),
              Column(children: [Text('1*')]),
            ]),
            TableRow(children: [
              Column(children: [Text('Javatpoint')]),
              Column(children: [Text('MySQL')]),
              Column(children: [Text('2*')]),
            ]),
            TableRow(children: [
              Column(children: [Text('Javatpoint')]),
              Column(children: [Text('ReactJS')]),
              Column(children: [Text('3*')]),
            ]),
            TableRow(children: [
              Column(children: [Text('Javatpoint')]),
              Column(children: [Text('ReactJS')]),
              Column(children: [Text('4*')]),
            ]),
            // TableRow(children: [
            //   Column(children: [Text('Javatpoint')]),
            //   Column(children: [Text('ReactJS')]),
            //   Column(children: [Text('5*')]),
            // ]),
            // TableRow(children: [
            //   Column(children: [Text('Javatpoint')]),
            //   Column(children: [Text('ReactJS')]),
            //   Column(children: [Text('6*')]),
            // ]),
          ],
        ),
      ),
    ]));
  }
}
