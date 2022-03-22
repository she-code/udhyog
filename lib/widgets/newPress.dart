import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/providers/auth.dart';
import 'package:udhyog/providers/press.dart';

class NewPress extends StatefulWidget {
  Function addPress;
  NewPress(this.addPress);

  @override
  State<NewPress> createState() => _NewPressState();
}

class _NewPressState extends State<NewPress> {
  @override
  Widget build(BuildContext context) {
    TextEditingController pressNameCont = TextEditingController();
    TextEditingController pressTypeCont = TextEditingController();
    final GlobalKey<FormState> _form = GlobalKey();
    final autTok = Provider.of<Auth>(context, listen: false).token;
    Future submitData() async {
      _form.currentState!.save();
      //print({autTok});
      try {
        await Provider.of<PressProvider>(context, listen: false)
            .addPressDb(pressTypeCont.text, autTok!);
      } catch (e) {
        print(e);
      }
    }
    //   if (pressNameCont.text.isEmpty) {
    //     return;
    //   }
    //   //final enteredTitle = pressTypeCont.text;
    //   final enteredType = pressNameCont.text;

    //   if (enteredType.isEmpty) {
    //     return;
    //   }
    //   // to access properties and methods of the widget class
    //   // widget.addPress(
    //   //   pressNameCont.text,
    //   //   pressTypeCont.text,
    //   // );

    //   Navigator.of(context).pop();
    // }

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // TextField(
                //   decoration: const InputDecoration(labelText: 'Name'),
                //   controller: pressNameCont,
                //   onSubmitted: (_) => submitData(),
                // ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Type'),
                  controller: pressTypeCont,
                  // keyboardType: TextInputType.number,
                  onSubmitted: (_) => submitData(),

                  //  onChanged: (value) => amountInput = value,
                ),
                SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                    onPressed: submitData,
                    child: Text('Add Press'),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        textStyle: TextStyle(
                          color: Theme.of(context).textTheme.button?.color,
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
