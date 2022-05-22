import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udhyog/widgets/logoHeading.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import 'mainPage.dart';

class LoginUP extends StatefulWidget {
  const LoginUP({Key? key}) : super(key: key);

  @override
  State<LoginUP> createState() => _LoginUPState();
}

class _LoginUPState extends State<LoginUP> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController company = TextEditingController();
  Color green = Color(0xFF008001);
  Color ins = Color(0xFFD7D8DA);
  Color backG = Color(0xFFE6E7E9);
  Color iconColor = Color(0xFF70CF7D);
  final GlobalKey<FormState> _form = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;

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
              child: Text('Okay'))
        ],
      ),
    );
  }

  Future submit() async {
    print({_authData});
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      print({_authData});
      await Provider.of<Auth>(context, listen: false).signin(
          // _authData['company'].toString(),
          _authData['email'].toString(),
          _authData['password'].toString());
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      print(e.toString());
      switch (e.toString()) {
        case "Email already registered":
          errorMessage = "Email already registered";
          break;
        case "User not found":
          errorMessage = "User not found";
          break;
        case "Invalid email or password":
          errorMessage = "Invalid email or password";
          break;
        default:
          errorMessage = 'Authentication failed';
          break;
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      print({e.toString()});
      const errorMessage = "Couldn't authenticate please try again";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                // top: 10,
                // left: 10,
                // right: 10,
                //adding padding based on the media size
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            color: backG,
            height: deviceSize.height -
                MediaQuery.of(context).viewInsets.bottom +
                432,
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              children: [
                // const LogoHeading(),
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Form(
                    key: _form,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Container(
                          //   child: const Text(
                          //     'Udhyog 4.0 (U4) is a start-up initiation by professionals in 2019, and mainly provides technological solutions related to emerging technologies such as Industry 4.0. This in turn transform existing industrial setup into SMART and sustainable manufacturing setup. ',
                          //     maxLines: 5,
                          //     style: TextStyle(overflow: TextOverflow.ellipsis),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          Container(
                            width: double.maxFinite,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: iconColor,
                                  size: 20,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.lightGreenAccent.shade400,
                                      width: 1.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: "Email",
                                // border: Border.all(color: Colors.black12,width: 2),
                              ),
                              controller: email,
                              validator: (value) {
                                if (!value!.contains('@')) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['email'] = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon:
                                  Icon(Icons.lock, color: iconColor, size: 15),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.lightGreenAccent.shade400,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              labelText: "Password",
                              // border: Border.all(color: Colors.black12,width: 2),
                            ),
                            controller: password,
                            validator: (value) {
                              if (value!.length < 5) {
                                return 'Password must contain atleast 6 characthers';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value!;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ElevatedButton(
                                child: Text(
                                  "Sign in".toUpperCase(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                onPressed: submit,
                                //     () {
                                //   Navigator.of(context)
                                //       .pushReplacementNamed(MainPage.routeName);
                                // },
                                style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shadowColor: green,
                                  padding: EdgeInsets.all(20),
                                  primary: green,
                                  minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot password'),
                            style: TextButton.styleFrom(primary: Colors.black),
                          )
                        ]),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
