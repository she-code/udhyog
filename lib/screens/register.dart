import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../widgets/addImage.dart';
import '../models/http_exception.dart';
import '../providers/auth.dart';
import 'mainPage.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const String routeName = '/register';
  @override
  State<Register> createState() => _RegisterState();
}

enum gstAvilable { yes, no }

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
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

// focus nodes
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _companyFocusNode;
  late FocusNode _confirmPassFocusNode;
  late FocusNode _pinFocusNode;
  late FocusNode _address1FocusNode;
  late FocusNode _address2FocusNode;
  late FocusNode _cityFocusNode;
  late FocusNode _countryFocusNode;
  late FocusNode _stateFocusNode;
  late FocusNode _webFocusNode;
  late FocusNode _logoFocusNode;
  late FocusNode _contactPersonFocusNode;
  late FocusNode _phoneFocusNode;
  late FocusNode _gstFocusNode;
  late FocusNode _gstValFocusNode;

// variables
  var nextPage = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //focus nodes
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _companyFocusNode = FocusNode();
    _confirmPassFocusNode = FocusNode();
    _pinFocusNode = FocusNode();
    _address1FocusNode = FocusNode();
    _address2FocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _countryFocusNode = FocusNode();
    _stateFocusNode = FocusNode();
    _webFocusNode = FocusNode();
    _logoFocusNode = FocusNode();
    _contactPersonFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
    _gstFocusNode = FocusNode();
    _gstValFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _companyFocusNode.dispose();
    _confirmPassFocusNode.dispose();
    _contactPersonFocusNode.dispose();
    _countryFocusNode.dispose();
    _stateFocusNode.dispose();
    _pinFocusNode.dispose();
    _cityFocusNode.dispose();
    _address1FocusNode.dispose();
    _address2FocusNode.dispose();
    _webFocusNode.dispose();
    _logoFocusNode.dispose();
    _phoneFocusNode.dispose();
    _gstFocusNode.dispose();
    _gstValFocusNode.dispose();
  }

//variables
  Color green = Color(0xFF008001);
  Color ins = Color(0xFFD7D8DA);
  Color backG = Color(0xFFE6E7E9);
  Color iconColor = Color(0xFF70CF7D);
//global keys
  final GlobalKey<FormState> _form = GlobalKey();
  final Map<String, dynamic> _authData = {
    'company_id': '',
    'company': '',
    'password': '',
    'address1': '',
    'address2': '',
    'email': '',
    'city': '',
    'country': '',
    'pin': '',
    "logo": File(''),
    "state": '',
    "cellNo": '',
    "gst": '',
    "gstNo": '',
    "contactPerson": '',
    "webpage": ''
  };
  var _isLoading = false;
  var isAddress = false;
  var isPersonal = true;
  var isCompInfo = false;
  gstAvilable _gstAvilable = gstAvilable.yes;
  File? _pickedImage;
  XFile? _pickedFile;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    _pickedFile = (await picker.pickImage(source: ImageSource.gallery));
    final pickedImageFile = File(_pickedFile!.path);
    if (_pickedFile != null) {
      setState(() {
        _pickedImage = File(_pickedFile!.path);
        _authData['logo'] = _pickedImage;
      });
      // var stream = new http.ByteStream(_pickedImage!.openRead());
      // stream.cast();
      // var length = await _pickedImage!.length();
      // var url = Uri.parse("uri");
      // var request = new http.MultipartRequest('POST', url,);
      // request.fields['company'] = "title";
      // var multipart = new http.MultipartFile('logo', stream, length);
      // request.files.add(multipart);
      // var response = await request.send();
      // if (response.statusCode == 200) {
      //   print("image uploaded");
      // }
    }
    // final imageForSendToAPI = await _pickedFile.readAsBytes();
    // setState(() {
    //   _pickedImage = pickedImageFile;
    //   _authData['logo'] = _pickedImage.toString();
    // });
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
          _authData['logo'],
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

  Widget _displayPersonalInfo() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _companyFocusNode,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.factory,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Company*",
              // errorText: _errorText,
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: company,
            validator: (value) {
              // if (!value!.contains('@')) {
              //   return 'Invalid company address';
              // }
              if (value!.isEmpty) {
                _companyFocusNode.requestFocus();
                return 'Company name can not be empty';
              }
              return null;
            },
            onSaved: (value) {
              _authData['company'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_emailFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Email*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: email,
            validator: (value) {
              if (!value!.isValidEmail()) {
                _emailFocusNode.requestFocus();

                return 'Invalid email address';
              }
              if (value.isEmpty) {
                _emailFocusNode.requestFocus();

                return 'Email can not be empty';
              }
              return null;
            },
            onSaved: (value) {
              _authData['email'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _passwordFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Password*",

              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: password,
            validator: (value) {
              if (value!.isEmpty) {
                _passwordFocusNode.requestFocus();

                return 'Password can not be empty';
              } else if (value.length < 8) {
                _passwordFocusNode.requestFocus();

                return 'Password must contain at least 8 characters';
              }
              //   return null;
            },
            onSaved: (value) {
              _authData['password'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_confirmPassFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _confirmPassFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Confirm password*",
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
          height: 15,
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ElevatedButton(
            child: Text(
              "Continue",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // setState(() {
              //   isAddress = !isAddress;
              //   isPersonal = !isPersonal;
              // });
              _form.currentState!.save();
              if (!_form.currentState!.validate()) {
                return;
              }
              setState(() {
                nextPage = !nextPage;
                isAddress = !isAddress;
                isPersonal = !isPersonal;
              });
            },
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
        ElevatedButton(onPressed: _pickImage, child: Text("upload")),
        Container(
            child: _pickedImage != null
                ? Image.file(
                    File(_pickedFile!.path),
                    width: 50,
                    height: 50,
                  )
                : Text("data"))
      ],
    );
  }

  Widget _displayAddress() {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                isAddress = !isAddress;
                isPersonal = !isPersonal;
              });
            },
            icon: Icon(Icons.arrow_back)),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _address1FocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_city,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Address 1*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: address1,
            validator: (value) {
              if (value!.isEmpty) {
                _address1FocusNode.requestFocus();
                return 'Address can not be empty';
              }
              return null;
            },
            onSaved: (value) {
              _authData['address1'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_address2FocusNode);
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
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
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
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_cityFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          focusNode: _cityFocusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_city, color: iconColor, size: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).errorColor, width: 2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.lightGreenAccent.shade400, width: 1.5),
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelText: "City*",
            // border: Border.all(color: Colors.black12,width: 2),
          ),
          controller: city,
          validator: (value) {
            if (value!.isEmpty) {
              _cityFocusNode.requestFocus();
              return 'City must be inserted';
            }

            return null;
          },
          onSaved: (value) {
            _authData['city'] = value!;
          },
          onFieldSubmitted: (_) {
            FocusScope.of(context).requestFocus(_pinFocusNode);
          },
        ),
        const SizedBox(height: 10),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _pinFocusNode,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.pin,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Pin*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: pin,
            validator: (value) {
              // if (!value!.contains('@')) {
              //   return 'Invalid company address';
              // }
              if (value!.isEmpty) {
                _pinFocusNode.requestFocus();
                return 'Pin can not be empty';
              }
              return null;
            },
            onSaved: (value) {
              _authData['pin'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_stateFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _stateFocusNode,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.place,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "State*",
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
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_countryFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            focusNode: _countryFocusNode,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.place,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Country*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: country,
            validator: (value) {
              // if (!value!.contains('@')) {
              //   return 'Invalid country address';
              // }
              if (value!.isEmpty) {
                _countryFocusNode.requestFocus();
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
          width: 300,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: ElevatedButton(
            child: Text(
              "Continue",
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              _form.currentState!.save();
              if (!_form.currentState!.validate()) {
                return;
              }
              setState(() {
                isAddress = !isAddress;
                isCompInfo = !isCompInfo;
              });
            },
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
    );
  }

  Widget _displayCompInfo() {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                isAddress = !isAddress;
                isCompInfo = !isCompInfo;
              });
            },
            icon: Icon(Icons.arrow_back)),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _webFocusNode,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.web,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Website",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: web,
            onSaved: (value) {
              _authData['webpage'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_phoneFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _phoneFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Cell Number*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: cellNo,
            validator: (value) {
              if (value!.isEmpty) {
                _phoneFocusNode.requestFocus();
                return 'Phone number can not be empty';
              }
              //   return null;
            },
            onSaved: (value) {
              _authData['cellNo'] = value!;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_gstFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("GST* : "),
            ),
            Container(
              height: 50,
              width: 110,
              child: ListTile(
                // title: Text(
                //   "Report",
                //   style: TextStyle(color: Colors.grey, fontSize: 15),
                // ),
                trailing: Text(
                  "Yes",
                  style: TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                ),
                leading: Radio<gstAvilable>(
                  value: gstAvilable.yes,
                  groupValue: _gstAvilable,
                  onChanged: (gstAvilable? value) {
                    setState(() {
                      _gstAvilable = value!;
                      _authData["gst"] = describeEnum(value);
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
                trailing: Text(
                  "No",
                  style: TextStyle(
                      color: Color.fromARGB(169, 0, 0, 0), fontSize: 15),
                ),
                leading: Radio<gstAvilable>(
                  value: gstAvilable.no,
                  groupValue: _gstAvilable,
                  onChanged: (gstAvilable? value) {
                    setState(() {
                      _gstAvilable = value!;
                      _authData["gst"] = describeEnum(value);
                    });
                  },
                  activeColor: Colors.green,
                ),
              ),
            ),
          ]),
          // child: TextFormField(
          //   focusNode: _gstFocusNode,
          //   decoration: InputDecoration(
          //     prefixIcon: Icon(
          //       Icons.phone,
          //       color: iconColor,
          //       size: 20,
          //     ),
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide(color: Colors.black, width: 2),
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //     focusedBorder: OutlineInputBorder(
          //       borderSide: BorderSide(
          //           color: Colors.lightGreenAccent.shade400, width: 1.5),
          //       borderRadius: BorderRadius.circular(20.0),
          //     ),
          //     labelText: "Gst",
          //     // border: Border.all(color: Colors.black12,width: 2),
          //   ),
          //   controller: gst,
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       return 'You have to choose either yes or no';
          //     }
          //     //   return null;
          //   },
          //   onSaved: (value) {
          //     _authData['gst'] = value!;
          //   },
          // ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _gstValFocusNode,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.money,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "GST Number*",
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
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_logoFocusNode);
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          child: TextFormField(
            focusNode: _contactPersonFocusNode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: iconColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).errorColor, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent.shade400, width: 1.5),
                borderRadius: BorderRadius.circular(20.0),
              ),
              labelText: "Contact Person*",
              // border: Border.all(color: Colors.black12,width: 2),
            ),
            controller: contactPerson,
            validator: (value) {
              if (value!.isEmpty) {
                _contactPersonFocusNode.requestFocus();
                return 'Contact Person can not be empty';
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

        Row(
          children: [
            Container(
              child: Text(
                "Company Logo",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.image,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    label: Text(
                      'Add Image',
                      style:
                          TextStyle(color: Theme.of(context).primaryColorDark),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            color: backG,
            padding: EdgeInsets.all(15),
            child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isPersonal
                        ? Expanded(child: _displayPersonalInfo())
                        : SizedBox(),
                    isAddress ? Expanded(child: _displayAddress()) : SizedBox(),
                    isCompInfo
                        ? Expanded(child: _displayCompInfo())
                        : SizedBox()
                  ],
                ))),
      ),
    );
  }
}
