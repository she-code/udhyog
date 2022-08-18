import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../providers/auth.dart';

class LoginUP extends StatefulWidget {
  VoidCallback changeStatus;
  LoginUP(this.changeStatus);
  @override
  State<LoginUP> createState() => _LoginUPState();
}

class _LoginUPState extends State<LoginUP> {
  //controllers
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController company = TextEditingController();

//variables
  Color green = Color(0xFF008001);
  Color ins = Color(0xFFD7D8DA);
  Color backG = Color(0xFFE6E7E9);
  Color iconColor = Color(0xFF70CF7D);
  final GlobalKey<FormState> _form = GlobalKey();
  final Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  var _show = false;

  //focus nodes
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

//event handlers
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
    return SingleChildScrollView(
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
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _form,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 400,
                          child: TextFormField(
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: iconColor,
                                size: 20,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).errorColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(20.0),
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
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 400,
                          child: TextFormField(
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            obscureText: _show ? false : true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              prefixIcon:
                                  Icon(Icons.lock, color: iconColor, size: 15),
                              suffixIcon: IconButton(
                                color: Colors.grey,
                                iconSize: 18,
                                onPressed: () {
                                  setState(() {
                                    _show = !_show;
                                  });
                                },
                                icon: _show
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).errorColor,
                                    width: 2),
                                borderRadius: BorderRadius.circular(20.0),
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          Container(
                            width: 400,
                            padding: EdgeInsets.all(12),
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
                                // padding: EdgeInsets.all(20),
                                primary: green,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: const Text("Don't have an account?")),
                  TextButton(
                    onPressed: widget.changeStatus,
                    // () {
                    //   Navigator.of(context).pushNamed(Register.routeName);
                    // },
                    child: const Text('Sign Up'),
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColorDark),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
                style: TextButton.styleFrom(
                    primary: Theme.of(context).primaryColorDark),
              )
            ],
          )),
    );
  }
}
