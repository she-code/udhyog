import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/addImage.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import 'mainPage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // controllers
  TextEditingController password = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController web = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cellNo = TextEditingController();
  TextEditingController logo = TextEditingController();
  TextEditingController gst = TextEditingController();
  TextEditingController gstNo = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController company_id = TextEditingController();
  TextEditingController company = TextEditingController();

//variables
  Color green = Color(0xFF008001);
  Color ins = Color(0xFFD7D8DA);
  Color backG = Color(0xFFE6E7E9);
  Color iconColor = Color(0xFF70CF7D);
//global keys
  final GlobalKey<FormState> _form = GlobalKey();
  final Map<String, String> _authData = {
    'company_id': '',
    'company': '',
    'password': '',
    'address1': '',
    'address2': '',
    'email': '',
    'city': '',
    'country': '',
    'pin': '',
    "logo": '',
    "state": '',
    "cellNo": '',
    "gst": '',
    "gstNo": '',
    "contactPerson": '',
    "webpage": ''
  };
  var _isLoading = false;
  File _pickedImage = File('');
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    final imageForSendToAPI = await pickedImage.readAsBytes();
    setState(() {
      _pickedImage = pickedImageFile;
      _authData['logo'] = _pickedImage.toString();
    });
    //pickImage(source: ImageSource.gallery);
  }

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
      // _authData['company_id'] = "U4FRUITT";
      print({_authData});
      await Provider.of<Auth>(context, listen: false).signup(
          //  _authData['company_id'].toString(),
          _authData['company'].toString(),
          _authData['email'].toString(),
          _authData['password'].toString(),
          _authData['address1'].toString(),
          _authData['address2'].toString(),
          _authData['city'].toString(),
          int.parse(_authData['pin'].toString()),
          _authData['state'].toString(),
          _authData['country'].toString(),
          int.parse(_authData['cellNo'].toString()),
          _authData['gst'].toString(),
          _authData['gstNo'].toString(),
          _authData['contactPerson'].toString(),
          _authData['logo'].toString(),
          _authData['webpage'].toString());
    } on HttpException catch (e) {
      var errorMessage = 'Authentication failed';
      print(e.toString());
      switch (e.toString()) {
        case "user with this email already exists":
          errorMessage = "user with this email already exists";
          break;
        case "company already registered":
          errorMessage = "company already registered";
          break;
        case "User not found":
          errorMessage = "User not found";
          break;
        case "Invalid company or password":
          errorMessage = "Invalid company or password";
          break;
        default:
          errorMessage = 'Authentication failed';
          break;
      }
      _showErrorDialog(errorMessage);
    } catch (e) {
      print({e});
      const errorMessage = "Couldn't authenticate please try again";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.factory,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Company",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: company,
                      validator: (value) {
                        // if (!value!.contains('@')) {
                        //   return 'Invalid company address';
                        // }
                        if (value!.isEmpty) {
                          return 'Company name can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['company'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Address 1",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: address1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Address can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['address1'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.location_city,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Address 2",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: address2,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Address can not be empty';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _authData['address2'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.location_city, color: iconColor, size: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightGreenAccent.shade400,
                            width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      labelText: "City",
                      // border: Border.all(color: Colors.black12,width: 2),
                    ),
                    controller: city,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'City must be inserted';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _authData['city'] = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.pin,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Pin",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: pin,
                      validator: (value) {
                        // if (!value!.contains('@')) {
                        //   return 'Invalid company address';
                        // }
                        if (value!.isEmpty) {
                          return 'Pin can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['pin'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.place,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "State",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: state,
                      validator: (value) {
                        // if (!value!.contains('@')) {
                        //   return 'Invalid State address';
                        // }
                        if (value!.isEmpty) {
                          return 'State can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['state'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.place,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Country",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: country,
                      validator: (value) {
                        // if (!value!.contains('@')) {
                        //   return 'Invalid country address';
                        // }
                        if (value!.isEmpty) {
                          return 'Country can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['country'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.web,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Website",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: web,
                      // validator: (value) {
                      //   // if (!value!.contains('@')) {
                      //   //   return 'Invalid web address';
                      //   // }
                      //   if (value!.isEmpty) {
                      //     return 'web can not be empty';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        _authData['webpage'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
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
                        if (value.isEmpty) {
                          return 'Email can not be empty';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Cell Number",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: cellNo,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number can not be empty';
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        _authData['cellNo'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   width: double.maxFinite,
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       prefixIcon: Icon(
                  //         Icons.phone,
                  //         color: iconColor,
                  //         size: 20,
                  //       ),
                  //       enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.black, width: 2),
                  //         borderRadius: BorderRadius.circular(20.0),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(
                  //             color: Colors.lightGreenAccent.shade400,
                  //             width: 1.5),
                  //         borderRadius: BorderRadius.circular(20.0),
                  //       ),
                  //       labelText: "Company logo",
                  //       // border: Border.all(color: Colors.black12,width: 2),
                  //     ),
                  //     controller: logo,
                  //     // validator: (value) {
                  //     //   if (value!.isEmpty) {
                  //     //     return 'Phone number can not be empty';
                  //     //   }
                  //     //   //   return null;
                  //     // },
                  //     onSaved: (value) {
                  //       _authData['logo'] = value!;
                  //     },
                  //   ),
                  //  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Gst",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: gst,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You have to choose either yes or no';
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        _authData['gst'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "GST Number",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: gstNo,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Gst number can not be empty';
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        _authData['gstNo'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Contact Person",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: contactPerson,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can not be empty';
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        _authData['contactPerson'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
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
                        if (value!.isEmpty) {
                          return 'Password can not be empty';
                        } else if (value.length < 8) {
                          return 'Password must contain at least 8 characters';
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        _authData['password'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.maxFinite,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone,
                          color: iconColor,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.lightGreenAccent.shade400,
                              width: 1.5),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: "Confirm password",
                        // border: Border.all(color: Colors.black12,width: 2),
                      ),
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You have to confirm password';
                        } else if (value != password.text) {
                          return "Passwords don't match";
                        }
                        //   return null;
                      },
                      onSaved: (value) {
                        // _authData['confi'] = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Text(
                          "Company Logo",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          child: TextButton.icon(
                              onPressed: _pickImage,
                              icon: Icon(
                                Icons.image,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              label: Text(
                                'Add Image',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark),
                              ))),
                    ],
                  ),
                  //AddImage(),
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
                          "Register".toUpperCase(),
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
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                ],
              ))),
    );
  }
}
