import 'package:flutter/material.dart';

class PressType extends StatefulWidget {
  String pressTy;
  PressType(this.pressTy);
  @override
  State<PressType> createState() => _PressTypeState();
}

class _PressTypeState extends State<PressType> {
  String dropDownValue = "Automatic";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: const Text("Press Type:"),
          ),
          DropdownButton<String>(
            value: dropDownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
                widget.pressTy = dropDownValue;
                print(widget.pressTy);
              });
            },
            style: const TextStyle(
                //te
                color: Colors.grey, //Font color
                fontSize: 15 //font size on dropdown button
                ),
            items: <String>[
              'Automatic',
              'Semi Automatic',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
