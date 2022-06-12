import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/press.dart';

class Overview extends StatefulWidget {
  final String press_name;
  final String press_id;
  final String location;
  final String frequency;
  final String static_id;
  final String TypeOfPress;
  Overview(this.press_name, this.press_id, this.location, this.frequency,
      this.static_id, this.TypeOfPress);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  Future deletePres() async {
    print("delete");
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Press will be deleted"),
        content: Text("Are you sure?"),
        actions: [
          TextButton(
              onPressed: () async {
                await Provider.of<PressProvider>(context, listen: false)
                    .removePress(widget.press_id);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Press deleted")));

                Navigator.of(ctx).pop();
              },
              child: Text('Delete')),
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pressData = Provider.of<PressProvider>(context).presses;
    var deviceSize = MediaQuery.of(context).size;
    Color backG = const Color.fromARGB(174, 230, 231, 233);
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            key: ValueKey(widget.press_id),
            flex: 2,
            onPressed: (_) {
              deletePres();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (_) {
              print("object");
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            // height: 100,
            width: deviceSize.width,
            padding: const EdgeInsets.all(8),
            // color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Press Name:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Press Type:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Dynamic ID:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Static ID:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Location:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Frequency:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Paymnet:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StringUtils.capitalize(widget.press_name)),
                        Text(StringUtils.capitalize(widget.TypeOfPress)),
                        Text(widget.press_id),
                        Text(widget.press_id.toUpperCase()),
                        Text(widget.location),
                        Text(widget.frequency),
                        const Text("Paid")
                      ]),
                ])),
      ),
    );
  }
}
