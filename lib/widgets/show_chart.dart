import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/models/pressData.dart';
import 'package:udhyog/providers/press.dart';

class ShowChart extends StatefulWidget {
  @override
  State<ShowChart> createState() => _ShowChartState();
  var id;
  var pressDataList;
  ShowChart(this.id, this.pressDataList);
}

enum choose_temp { lowTemp, highTemp, hoseTemp, blockTemp }

class _ShowChartState extends State<ShowChart> {
  choose_temp? _tempChoice = choose_temp.lowTemp;
  String dropDownValue = "Select";

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Text(
              "Select Temperature: ",
              style: TextStyle(fontSize: 16),
            ),
            // margin: EdgeInsets.only(top: 15),
          ),
          Container(
            color: Colors.white,
            alignment: Alignment.center,
            padding: EdgeInsets.all(6),
            child: DropdownButton<String>(
              dropdownColor: Colors.white,
              value: dropDownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropDownValue = newValue!;
                  print(dropDownValue);
                  if (dropDownValue == 'Temp Low') {
                    print("low");
                    Provider.of<PressProvider>(context, listen: false)
                        .getDailyTempLowPressData(widget.id);
                    print({widget.pressDataList});
                    widget.pressDataList.asMap().entries.map(
                        (index) => print('yes')
                        // print(
                        //     widget.pressDataList[index].TankLowerTemp.toString())
                        );
                  }
                });
              },
              style: const TextStyle(fontSize: 15),
              items: <String>[
                'Select',
                'Temp Low',
                'Temp High',
                'Temp Block',
                'Temp Hose',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Container(
          //   width: 130,
          //   child: ListTile(
          //     //title: Text("Temp Low"),
          //     trailing: Text("Temp Low"),
          //     leading: Radio<choose_temp>(
          //       value: choose_temp.lowTemp,
          //       groupValue: _tempChoice,
          //       onChanged: (choose_temp? value) {
          //         setState(() {
          //           _tempChoice = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: 130,
          //   child: ListTile(
          //     //title: Text("Temp Low"),
          //     trailing: Text("Temp high"),
          //     leading: Radio<choose_temp>(
          //       value: choose_temp.lowTemp,
          //       groupValue: _tempChoice,
          //       onChanged: (choose_temp? value) {
          //         setState(() {
          //           _tempChoice = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),

          // Container(
          //   width: 110,
          //   height: 80,
          //   child: ListTile(
          //     // title: Text(
          //     //   "Report",
          //     //   style: TextStyle(color: Colors.grey, fontSize: 15),
          //     // ),
          //     trailing: Text(
          //       "Temperature High",
          //       style: TextStyle(
          //           color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
          //     ),
          //     leading: Radio<choose_temp>(
          //       value: choose_temp.highTemp,
          //       groupValue: _tempChoice,
          //       onChanged: (choose_temp? value) {
          //         setState(() {
          //           _tempChoice = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: 110,
          //   height: 80,
          //   child: ListTile(
          //     // title: Text(
          //     //   "Chart",
          //     //   style: TextStyle(color: Colors.grey, fontSize: 15),
          //     // ),
          //     trailing: Text(
          //       "Hose Temp",
          //       style: TextStyle(
          //           color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
          //     ),
          //     leading: Radio<choose_temp>(
          //       value: choose_temp.hoseTemp,
          //       groupValue: _tempChoice,
          //       onChanged: (choose_temp? value) {
          //         setState(() {
          //           _tempChoice = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),
          // Container(
          //   width: 115,
          //   height: 80,
          //   child: ListTile(
          //     // title: Text(
          //     //   "Chart",
          //     //   style: TextStyle(color: Colors.grey, fontSize: 15),
          //     // ),
          //     trailing: Text(
          //       "Block Temp",
          //       style: TextStyle(
          //           color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
          //     ),
          //     leading: Radio<choose_temp>(
          //       value: choose_temp.blockTemp,
          //       groupValue: _tempChoice,
          //       onChanged: (choose_temp? value) {
          //         setState(() {
          //           _tempChoice = value;
          //         });
          //       },
          //       activeColor: Colors.green,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
