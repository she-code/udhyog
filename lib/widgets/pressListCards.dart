import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/providers/press.dart';
import 'package:udhyog/screens/press_details.dart';

class PressListCards extends StatefulWidget {
  final String press_id;
  final String press_name;
  var pressDetails;

  PressListCards(this.press_id, this.press_name, this.pressDetails);

  @override
  State<PressListCards> createState() => _PressListCardsState();
}

class _PressListCardsState extends State<PressListCards> {
  var showActive = false;
  var disabled = true;

  @override
  Widget build(BuildContext context) {
    bool openDetails = false;
    final snackBar = SnackBar(
      content: Text('Press details is empty'),
      duration: Duration(seconds: 3),
    );
    //  Scaffold.of(context).showSnackBar(snackBar);

    return GestureDetector(
      onTap: () {
        if (!widget.pressDetails.isEmpty) {
          Navigator.of(context)
              .pushNamed(PressDetails.routeName, arguments: widget.press_id);
          setState(() {
            showActive = !showActive;
          });
          Provider.of<PressProvider>(context, listen: false)
              .getPress(widget.press_id);
        } else {
          setState(() {
            openDetails = true;
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            print("object");
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 70,
        margin: EdgeInsets.all(6),
        padding: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            color: showActive
                ? Colors.orange
                : widget.pressDetails.isEmpty
                    ? Colors.grey.shade300
                    : Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: const [
              BoxShadow(
                color: Colors.white,
                blurRadius: 25,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
                //offset:
              )
            ]),
        // padding: EdgeInsets.symmetric(horizontal: 5),
        // child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.white,
        //     // padding: EdgeInsets.all(6),
        //     shadowColor: Colors.white,
        //     //elevation: 3
        //   ),
        child: Text(
          StringUtils.capitalize(widget.press_name),
          style: TextStyle(color: Colors.black),
        ),
        // onPressed: () {
        //   Navigator.of(context)
        //       .pushNamed(PressDetails.routeName, arguments: widget.press_id);
        // },
        // ),
      ),
    );
  }
}
