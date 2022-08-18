import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/screens/mainPage.dart';
import 'package:udhyog/widgets/userNameHeader.dart';
import '../models/http_exception.dart';
import '../providers/press.dart';
import '../screens/payment.dart';
import '../widgets/logoHeading.dart';
import '../widgets/mainFooter.dart';

class NewPress extends StatefulWidget {
  static const routeName = "/newPress";
  //Function addPress;
  NewPress();

  @override
  State<NewPress> createState() => _NewPressState();
}

enum frequency {
  oneS,
  thirtyS,
  sixtyS,
  threehunS,
  tenMin,
  TwenMin,
  thirtyMin,
  oneHour
}

extension freEnum on frequency {
  // String get name => describeEnum(this);
  int get freq {
    switch (this) {
      case frequency.oneS:
        return 1;
      case frequency.thirtyS:
        return 30;
      case frequency.sixtyS:
        return 60;
      case frequency.threehunS:
        return 300;
      case frequency.tenMin:
        return 600;
      case frequency.TwenMin:
        return 1200;
      case frequency.thirtyMin:
        return 1800;
      case frequency.oneHour:
        return 3600;
      default:
        return 600;
    }
  }
  // 1, 30, 60, 300, 10min,20min,30min,1hour
}

class _NewPressState extends State<NewPress> {
  final _staticFocusNode = FocusNode();
  final _locationFocusNode = FocusNode();
  final _hotsFocusNode = FocusNode();
  final _hotsPassFocusNode = FocusNode();
  frequency? _frequency;
  TextEditingController staticId = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _hotspot = TextEditingController();
  TextEditingController _hotsPassword = TextEditingController();
  String? dropDownValue;

  //global keys
  final GlobalKey<FormState> _form = GlobalKey();

  final Map<String, dynamic> _pressData = {
    "static_id": '',
    "dynamicId": '',
    "location": "",
    "hotspot": "",
    "hotsPassword": "",
    "frequency": 0,
    "TypeOfPress": ""
  };
  var _isLoading = false;

  //final autTok = Provider.of<Auth>(context, listen: false).token;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error occured"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'))
        ],
      ),
    );
  }

  Future submitData() async {
    print({_pressData});

    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<PressProvider>(context, listen: false).addPressDb(
        _pressData["location"].toString(),
        _pressData["static_id"].toString(),
        _pressData["hotsPassword"].toString(),
        _pressData["hotspot"].toString(),
        _pressData["frequency"].toString(),
        _pressData["TypeOfPress"].toString(),
        // autTok!
      );
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    } on HttpException catch (e) {
      var errorMessage = 'Authentication Failed';
      print(e.toString());
      switch (e.toString()) {
        case 'Invalid press data':
          errorMessage = 'Invalid press data';
          break;
      }
    } catch (e) {
      print(e.toString());
      const errorMessage = "Unable to create a press";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _staticFocusNode.dispose();
    _locationFocusNode.dispose();
    _hotsFocusNode.dispose();

    _hotsPassFocusNode.dispose();

    super.dispose();
  }

  Widget frequencyWidget() {
    return Container(
        width: 400,
        // padding: EdgeInsets.symmetric(horizontal: 8),
        // height: 250,
        alignment: Alignment.center,
        child: Wrap(
            //S scrollDirection: Axis.horizontal,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Frequency: "),
              ),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  // title: Text(
                  //   "Report",
                  //   style: TextStyle(color: Colors.grey, fontSize: 15),
                  // ),
                  trailing: const Text(
                    "1 sec",
                    style: TextStyle(
                        color: const Color.fromARGB(169, 0, 0, 0),
                        fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.oneS,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.oneS.freq;
                        print(frequency.oneS.freq);
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  // title: Text(
                  //   "Report",
                  //   style: TextStyle(color: Colors.grey, fontSize: 15),
                  // ),
                  trailing: const Text(
                    "30 sec",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.thirtyS,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.thirtyS.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  // title: Text(
                  //   "Report",
                  //   style: TextStyle(color: Colors.grey, fontSize: 15),
                  // ),
                  trailing: const Text(
                    "60 sec",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.sixtyS,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.sixtyS.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 110,
                child: ListTile(
                  trailing: const Text(
                    "300 sec",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.threehunS,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.threehunS.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 110,
                child: ListTile(
                  trailing: const Text(
                    "10 min",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.tenMin,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.tenMin.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 110,
                child: ListTile(
                  trailing: const Text(
                    "20 min",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.TwenMin,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.TwenMin.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 110,
                child: ListTile(
                  trailing: const Text(
                    "30 min",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.thirtyMin,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.thirtyMin.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 110,
                child: ListTile(
                  trailing: const Text(
                    "1 hour",
                    style: TextStyle(
                        color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                  ),
                  leading: Radio<frequency>(
                    value: frequency.oneHour,
                    groupValue: _frequency,
                    onChanged: (frequency? value) {
                      setState(() {
                        _frequency = value;
                        _pressData["frequency"] = frequency.oneHour.freq;
                      });
                    },
                    activeColor: Colors.green,
                  ),
                ),
              ),
            ]));
  }

  Widget pressTypeWidget() {
    return Row(
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
              _pressData["TypeOfPress"] = dropDownValue!;
              print(_pressData["TypeOfPress"]);
            });
          },
          style: const TextStyle(
              //te
              // color: Colors.grey, //Font color
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
          hint: const Text('Select'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color green = const Color(0xFF008001);

    //controllers

    final deviceSize = MediaQuery.of(context).size;
    Color back = const Color(0xFFeeeee4);
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(color: back),
        width: deviceSize.width,
        height: deviceSize.height,
        child: ListView(shrinkWrap: true, children: [
          const LogoHeading(),
          const UserNameHeader(),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Wax Injection Press Monitoring System",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            // fit: FlexFit.loose,
            height: 600,
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: staticId,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_locationFocusNode);
                        },
                        focusNode: _staticFocusNode,
                        decoration: InputDecoration(
                            labelText: 'Static Id',
                            labelStyle: TextStyle(
                                color: _staticFocusNode.hasFocus
                                    ? Colors.green
                                    : Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: green, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ))),
                        onSaved: (value) {
                          _pressData["static_id"] = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Static Id must be inserted";
                          }
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 400,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _location,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_hotsFocusNode);
                        },
                        focusNode: _locationFocusNode,
                        decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: TextStyle(
                                color: _locationFocusNode.hasFocus
                                    ? Colors.green
                                    : Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: green, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ))),
                        onSaved: (value) {
                          _pressData["location"] = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Location must be inserted";
                          }
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      width: 400,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _hotspot,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_hotsPassFocusNode);
                        },
                        focusNode: _hotsFocusNode,
                        decoration: InputDecoration(
                            labelText: 'Hotspot Id',
                            labelStyle: TextStyle(
                                color: _staticFocusNode.hasFocus
                                    ? Colors.green
                                    : Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: green, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ))),
                        onSaved: (value) {
                          _pressData["hotspot"] = value!;
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: 400,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: _hotsPassword,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          //  FocusScope.of(context).requestFocus(_location);
                        },
                        focusNode: _hotsPassFocusNode,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Hotspot Password',
                            labelStyle: TextStyle(
                                color: _staticFocusNode.hasFocus
                                    ? Colors.green
                                    : Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 2),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: green, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.5,
                                ))),
                        onSaved: (value) {
                          _pressData["hotsPassword"] = value!;
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  //  PressType(_pressData["TypeOfPress"].toString()),
                  pressTypeWidget(),
                  //  freqWidget(),
                  frequencyWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 300,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: ElevatedButton(
                      child: Text(
                        "Create".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: submitData,
                      //     () {
                      //   Navigator.of(context)
                      //       .pushReplacementNamed(MainPage.routeName);
                      // },
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        shadowColor: green,
                        padding: const EdgeInsets.all(20),
                        primary: green,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
        //])
      ),
    ));
  }
}
